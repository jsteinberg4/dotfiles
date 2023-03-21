-- =============================
-- =    MISC
-- =============================

return {
	{
		-- add indent guides on bank lines
		"lukas-reineke/indent-blankline.nvim",
		opts = {
			char = "│",
			show_trailing_blankline_indent = false,
			show_current_context = false,
			filetype_exclude = {
				"help",
				"alpha",
				"dashboard",
				"neo-tree",
				"Trouble",
				"lazy",
			},
		},
	},
	{
		-- persistent & powerful undo abilities. Load when called.
		"mbbill/undotree",
		cmd = { "UndotreeShow", "UndotreeToggle" },
		keys = {
			{ "<leader>u", vim.cmd.UndotreeToggle, desc = "Toggle undotree" },
		},
	},

	{
		-- better window movement
		"s1n7ax/nvim-window-picker",
		version = "v1.*",
		keys = {
			{
				"<leader>pw",
				function()
					local picked_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()
					vim.api.nvim_set_current_win(picked_id)
				end,
				desc = "[P]ick [W]indow",
			},
		},
		opts = {
			include_current = false,
			autoselect_one = true,
			filter_rules = {
				bo = {
					-- ignore neo-tree or notify windows
					filetype = { "neo-tree", "neo-tree-popup", "notify" },
					-- Ignore terminal and quickfix buffers
					buftype = { "terminal", "quickfix" },
				},
			},
			other_win_hl_color = "#e35e4f",
		},
	},

	-- Comments
	{ "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },
	{
		"echasnovski/mini.comment",
		version = "*",
		event = "VeryLazy",
		opts = {
			hooks = {
				pre = function()
					require("ts_context_commentstring.internal").update_commentstring({})
				end,
			},
		},
		config = function(_, opts)
			require("mini.comment").setup(opts)
		end,
	},
}
