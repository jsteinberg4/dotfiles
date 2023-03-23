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
				ft = "lua",
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
				stylua = {
					settings = {
						Lua = {
							diagnostics = { globals = { "vim" } },
							workspace = { checkThirdParty = false },
							completion = { callSnippet = "Replace" },
						},
					},
				},
				pyright = {
					settings = {},
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
			for name, icon in pairs(require("jsteinberg.config").icons.diagnostics) do
				name = "DiagnosticSign" .. name
				vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
			end
			vim.diagnostic.config(opts.diagnostics)

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
					-- Python Formatters
					nls.builtins.formatting.autoflake, -- Remove unused imports
					nls.builtins.formatting.black, -- Black formatting
					nls.builtins.diagnostics.pylint, -- Linter
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
				-- Python:
				"pyright",
				"pylint",
				"usort",
				"autoflake",
				"black",
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

-- TODO: OLD SETUP
-- local lsp = require('lsp-zero')
-- lsp.preset("recommended")
--
--
--
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
