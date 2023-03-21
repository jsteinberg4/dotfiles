-- =============================
-- =    Lualine
-- =============================
return {
	{
		-- Fancier statusline
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = {
			icons_enabled = false,
			-- theme = vim.g.my_colors,
			component_separators = "|",
			section_separators = "",
		},
	},
}
