-- =============================
-- =    MISC
-- =============================

return {
    { 'nvim-lualine/lualine.nvim' }, -- Fancier statusline
    { 'lukas-reineke/indent-blankline.nvim' }, -- add indent guides on bank lines
    { 'numToStr/Comment.nvim' }, -- "gc" to comment regions

    { -- persistent & powerful undo abilities. Load when called.
        "mbbill/undotree",
        cmd = { "UndotreeShow", "UndotreeToggle" },
    },

    { -- better window movement
        's1n7ax/nvim-window-picker',
        version = 'v1.*',
        event = { "VimEnter", },
    },
}
