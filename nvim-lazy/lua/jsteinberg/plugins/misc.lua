-- =============================
-- =    MISC
-- =============================

return {
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
	{ -- which-key
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = { plugins = { spelling = true } },
		config = function(_, opts)
			require("which-key").setup(opts)

			local keymaps = {
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				["gz"] = { name = "+surrond" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				["<leader><tab>"] = { name = "+tabs" },
				["<leader>b"] = { name = "+buffer" },
				["<leader>c"] = { name = "+code" },
				["<leader>f"] = { name = "+file/find" },
				["<leader>g"] = { name = "+git" },
				["<leader>gh"] = { name = "+hunks" },
				["<leader>q"] = { name = "+quit/session" },
				["<leader>s"] = { name = "+search" },
				["<leader>u"] = { name = "+ui" },
				["<leader>w"] = { name = "+windows" },
				["<leader>x"] = { name = "+diagnostics/quickfix" },
			}
			if require("jsteinberg.util").has("noice.nvim") then
				keymaps["<leader>sn"] = { name = "+noice" }
			end
			require("which-key").register(keymaps)
		end,
	},
}
