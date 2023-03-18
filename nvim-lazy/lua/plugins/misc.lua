-- =============================
-- =    MISC
-- =============================

return {
    { 'nvim-lualine/lualine.nvim' }, -- Fancier statusline
    {
        -- add indent guides on bank lines
        'lukas-reineke/indent-blankline.nvim',
        char = '┊',
        show_trailing_blankline_indent = false,
    },
    { -- "gc" to comment regions
        'numToStr/Comment.nvim'
    },

    {
        -- persistent & powerful undo abilities. Load when called.
        "mbbill/undotree",
        cmd = { "UndotreeShow", "UndotreeToggle" },
    },

    {
        -- better window movement
        's1n7ax/nvim-window-picker',
        version = 'v1.*',
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
                    filetype = { 'neo-tree', 'neo-tree-popup', 'notify' },
                    -- Ignore terminal and quickfix buffers
                    buftype = { 'terminal', 'quickfix' },
                },
            },
            other_win_hl_color = "#e35e4f",
        },
    },
}
