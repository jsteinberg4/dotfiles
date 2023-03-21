-- =============================
-- =    LSP Setup
-- =============================

return {
	-- neovim-lsp
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			{ -- Completions/docs for Neovim's lua functions
				"folke/neodev.nvim",
				opts = { experimental = { pathStrict = true } },
			},
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			{
				-- Loads if nvim-cmp is present
				"hrsh7th/cmp-nvim-lsp",
				cond = function()
					return require("jsteinberg.util").has("nvim-cmp")
				end,
			},
		},
		---@class PluginLspOpts
		opts = {
			-- options for vim.diagnostic.config()
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 4, prefix = "●" },
				severity_sort = true,
			},

			-- Autoformat on save
			autoformat = true,

			-- Options for vim.lsp.buf.format
			-- `bufnr` and `filter` is handled by the LazyVim formatter,
			-- but can be also overridden when specified,
			format = {
				formatting_options = nil,
				timeout_ms = nil,
			},

			-- LSP Server settings
			---@type lspconfig.options
			servers = {
				-- set mason = false if you don't want a server installed by mason
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							workspace = { checkThirdParty = false },
							completion = { callSnippet = "Replace" },
						},
					},
				},
			},
			-- you can do any additional lsp server setup here
			-- return true if you don't want this server to be setup with lspconfig
			---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
			setup = {
				-- example to setup with typescript.nvim
				-- tsserver = function(_, opts)
				--   require("typescript").setup({ server = opts })
				--   return true
				-- end,
				-- Specify * to use this function as a fallback for any server
				-- ["*"] = function(server, opts) end,
			},
		},
		---@param opts PluginLspOpts
		config = function(_, opts)
			-- Setup autoformat
			require("jsteinberg.plugins.lsp.format").autoformat = opts.autoformat
			-- Setup formatting & keybinds
			require("jsteinberg.util").on_attach(function(client, buffer)
				require("jsteinberg.plugins.lsp.format").on_attach(client, buffer)
				require("jsteinberg.plugins.lsp.keymaps").on_attach(client, buffer)
			end)

			-- LSP Diagnostics
			-- TODO: Diagnostic symbols conf. Uses the lazyvim.config fancy module (not implemented here)

			local servers = opts.servers
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			-- Reusable function for configuring each LSP
			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, servers[server] or {})

				-- Use the most specific configuration available
				if opts.setup[server] then
					opts.setup[server](server, server_opts)
				elseif opts.setup["*"] then
					opts.setup["*"](server, server_opts)
				else
					require("lspconfig")[server].setup(server_opts)
				end
			end

			-- get all the servers that are available thourgh mason-lspconfig
			local have_mason, mlsp = pcall(require, "mason-lspconfig")
			local all_mslp_servers = {}
			if have_mason then
				all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
			end
			local ensure_installed = {} ---@type string[]
			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
					if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
						setup(server)
					else
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end

			if have_mason then
				mlsp.setup({ ensure_installed = ensure_installed })
				mlsp.setup_handlers({ setup })
			end
		end,
	},
	-- Formatters w/ null-ls
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "mason.nvim" },
		opts = function()
			-- Configures options for the null-ls.nvim plugin
			local nls = require("null-ls")
			return {
				root_dir = require("null-ls.utils").root_pattern(".null-ls.root", "Makefile", ".git"),
				-- TODO :: Consider configuring these more
				sources = {
					-- Diagnostics
					nls.builtins.diagnostics.todo_comments,
					nls.builtins.diagnostics.pylint,
					-- Python Formatters
					nls.builtins.formatting.black, -- Black formatting
					nls.builtins.formatting.autoflake, -- Remove unused imports
					nls.builtins.formatting.usort, -- Sort imports

					-- Other formatters
					nls.builtins.formatting.stylua, -- Lua formatter
					nls.builtins.formatting.shfmt, -- Bash formatting
				},
			}
		end,
	},
	-- Mason as a LSP/tool installer
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<CMD>Mason<CR>", desc = "Launch [c]ommand [m]ason", silent = true } },
		opts = {
			-- From old config
			-- -- Langauge servers to always install
			-- lsp.ensure_installed({
			--     'pyright',
			--     'lua_ls',
			--     'bashls',
			--     'jsonls',
			--     'marksman',
			--     'yamlls',
			--     'html',
			--     'cssls',
			-- })
			ensure_installed = {
				"stylua",
				"shfmt",
			},
		},
		---@param opts MasonSettings | {ensure_installed: string[]}
		config = function(_, opts)
			-- Function to install required plugins w/ Mason
			require("mason").setup(opts)
			local registry = require("mason-registry")

			-- Loops over all plugins in mason.opts.ensure_installed. Installs.
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = registry.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end

			-- Use the function defined above to install everything
			if registry.refresh then
				registry.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},
}

-- return {
--     { 'j-hui/fidget.nvim' }, -- Status updates for LSP

--
--
-- }

-- TODO: OLD SETUP
-- local lsp = require('lsp-zero')
-- lsp.preset("recommended")
--
-- local cmp = require('cmp')
-- local cmp_select = { cmp.SelectBehavior.Select }
-- local cmp_mappings = lsp.defaults.cmp_mappings({
--     ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--     ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--     ['<C-y>'] = cmp.mapping.confirm({ select = true }),
--     ["<C-Space>"] = cmp.mapping.complete(), -- <C-Space> triggers complete
-- })
--
-- lsp.setup_nvim_cmp({
--     -- See nvim-cmp docs for options
--     mapping = cmp_mappings,
--     sources = {
--         { name = 'path' },
--         { name = 'vim_lsp', keyword_length = 3 },
--         { name = 'buffer', keyword_length = 3 },
--         { name = 'luasnip', keyword_length = 2 },
--     }
-- })
--
--
-- -- local null_ls = require('null-ls')
-- -- =====================
-- -- = Setup behavior on LSP attach
-- -- =====================
-- -- local lsp_signature_cfg = {
-- --     bind = true, -- This is mandatory, otherwise border config won't get registered.
-- --     -- If you want to hook lspsaga or other signature handler, pls set to false
-- --     doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
-- --     -- set to 0 if you DO NOT want any API comments be shown
-- --     -- This setting only take effect in insert mode, it does not affect signature help in normal
-- --     -- mode, 10 by default
-- --     max_height = 12, -- max height of signature floating_window
-- --     max_width = 80, -- max_width of signature floating_window
-- --     noice = false, -- set to true if you using noice to render markdown
-- --     wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
-- --     floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
-- --     floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
-- --     -- will set to true when fully tested, set to false will use whichever side has more space
-- --     -- this setting will be helpful if you do not want the PUM and floating win overlap
-- --     close_timeout = 2000, -- close floating window after ms when laster parameter is entered
-- --     fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
-- --     hint_enable = true, -- virtual hint enable
-- --     hint_prefix = "🐼 ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
-- --     hint_scheme = "String",
-- --     hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
-- --     handler_opts = {
-- --         border = "rounded" -- double, rounded, single, shadow, none, or a table of borders
-- --     },
-- --     shadow_blend = 36, -- if you using shadow as border use this set the opacity
-- --     shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
-- --     always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
-- --     auto_close_after = 10, -- autoclose signature float win after x sec, disabled if nil.
-- --     timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
-- --     toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
-- --     select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
-- --     move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
-- -- }
--
-- local on_attach = function(_, bufnr)
--     local bind = function(mode, keymap, func, desc)
--         if desc then
--             desc = 'LSP: ' .. desc
--         end
--         vim.keymap.set(mode, keymap, func, {
--             buffer = bufnr, remap = false, desc = desc
--         })
--     end
--
--     -- require('lsp_signature').on_attach(lsp_signature_cfg, bufnr)
--
--     -- LSP Buffer keybinds
--     bind('n', "<leader>vrn", vim.lsp.buf.rename, "[V]ariable [R]e[n]ame")
--     bind('n', "<leader>ca", vim.lsp.buf.code_action, '[C]ode [A]ction')
--     bind('n', "gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
--     bind('n', "gI", vim.lsp.buf.implementation, '[G]oto [I]mplementation')
--     bind('n', "<leader>D", vim.lsp.buf.type_definition, "Type [D]efinition")
--     bind('i', "<C-h>", vim.lsp.buf.signature_help, "<Ctrl> + Signature [H]elp")
--     bind('n', "K", vim.lsp.buf.hover, 'Hover Documentation')
--     bind('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
--
--     -- Telescope LSP bindings
--     local t_builtin = require('telescope.builtin')
--     bind('n', "gr", t_builtin.lsp_references, "[G]oto [R]eferences")
--     bind("n", "<leader>ds", t_builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
--     bind("n", "<leader>ws", t_builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
--
--     -- Diagnostics keybinds
--     bind("n", "<leader>vd", vim.diagnostic.open_float, "Open [V]im [D]iagnostic")
--     bind("n", "[d", vim.diagnostic.goto_next, "Next [D]iagnostic")
--     bind("n", "]d", vim.diagnostic.goto_prev, "Prev [D]iagnostic")
--
--     -- Setup code formatting capabilities
--     vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
--         if vim.lsp.buf.format then
--             vim.lsp.buf.format()
--         elseif vim.lsp.buf.formatting then
--             vim.lsp.buf.formatting()
--         end
--     end, { desc = "Format current buffer with LSP" })
--
--     -- Automatically format the file when saving/writing
--     vim.api.nvim_create_autocmd('BufWritePre', {
--         buffer = bufnr,
--         callback = function()
--             vim.cmd("Format")
--         end
--     })
-- end
--
-- lsp.on_attach(on_attach)
-- -- null_ls.setup({
-- --     on_attach = on_attach,
-- --     sources = {
-- --         --[[ null_ls.builtins.formatting.stylua, ]]
-- --         null_ls.builtins.diagnostics.eslint,
-- --         null_ls.builtins.completion.spell,
-- --     },
-- -- })
--
--
-- -- ==============================
-- --      Run at End
-- -- ==============================
-- require('fidget').setup({})
--
-- lsp.setup() -- Run this at the end of file
-- vim.diagnostic.config({
--     virtual_text = true, -- Floating diagnostic text @ end of line
-- })
