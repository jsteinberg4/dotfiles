-- =============================
-- =    Treesitter
-- =============================
return {
	{
		-- Treesitter for highlighting + other goodies
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			{ "p00f/nvim-ts-rainbow", lazy = true },
		},
		keys = {
			{ "<C-Space>", desc = "Increment selection" },
			{ "<BS>", desc = "Decrement selection", mode = "x" },
		},
		-- I think this is called by lazy.nvim b/c treesitter doesn't have
		-- the standard setup function
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
		opts = {
			-- Rec: set to false unless the treesitter CLI is locally installed
			-- Automatically install missing parsers on opening a new file type
			auto_install = false,
			-- Install the ensured parsers asynchronously
			sync_install = false,
			indent = { enable = true, disable = "python" },
			highlight = { enable = true },
			-- This seems related to ts_context_commentstring
			context_commentstring = { enable = true, enable_autocmd = false },
			rainbow = {
				-- Rainbow brackets config
				enable = true,
				-- disable = {} -- List[str] of languages to disable this for
				extended_mode = true, -- also highlight non-braket delimiters
				max_file_lines = 1000, -- Disable for files over N lines
			},
			-- Add languages to be installed here that you want installed for treesitter
			ensure_installed = {
				"bash",
				"c",
				"css",
				"html",
				"javascript",
				"json",
				"lua",
				"luap",
				"markdown",
				"markdown_inline",
				"python",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"yaml",
			},
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-Space>",
					node_incremental = "<C-Space>",
					scope_incremental = "<nop>",
					node_decremental = "<BS>",
				},
			},
			-- textobjects = {
			--     select = {
			--         enable = true,
			--         lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
			--         keymaps = {
			--             -- You can use the capture groups defined in textobjects.scm
			--             ['aa'] = '@parameter.outer',
			--             ['ia'] = '@parameter.inner',
			--             ['af'] = '@function.outer',
			--             ['if'] = '@function.inner',
			--             ['ac'] = '@class.outer',
			--             ['ic'] = '@class.inner',
			--         },
			--     },
			--     move = {
			--         enable = true,
			--         set_jumps = true, -- whether to set jumps in the jumplist
			--         goto_next_start = {
			--             [']m'] = '@function.outer',
			--             [']]'] = '@class.outer',
			--         },
			--         goto_next_end = {
			--             [']M'] = '@function.outer',
			--             [']['] = '@class.outer',
			--         },
			--         goto_previous_start = {
			--             ['[m'] = '@function.outer',
			--             ['[['] = '@class.outer',
			--         },
			--         goto_previous_end = {
			--             ['[M'] = '@function.outer',
			--             ['[]'] = '@class.outer',
			--         },
			--     },
			--     swap = {
			--         enable = true,
			--         swap_next = {
			--             ['<leader>a'] = '@parameter.inner',
			--         },
			--         swap_previous = {
			--             ['<leader>A'] = '@parameter.inner',
			--         },
			--     },
			-- },
		},
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		init = function()
			-- PERF: no need to load the plugin, if we only need its queries for mini.ai
			local plugin = require("lazy.core.config").spec.plugins["nvim-treesitter"]
			local opts = require("lazy.core.plugin").values(plugin, "opts", false)
			local enabled = false
			if opts.textobjects then
				for _, mod in ipairs({ "move", "select", "swap", "lsp_interop" }) do
					if opts.textobjects[mod] and opts.textobjects[mod].enable then
						enabled = true
						break
					end
				end
			end
			if not enabled then
				require("lazy.core.loader").disable_rtp_plugin("nvim-treesitter-textobjects")
			end
		end,
	},
}
