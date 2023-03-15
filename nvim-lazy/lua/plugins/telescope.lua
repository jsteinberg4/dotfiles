-- =============================
-- =    Telescope.nvim
-- =============================
return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { -- Faster(?) fuzzy find algorithm
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = vim.fn.executable 'make' == 1
        },
        { 'nvim-tree/nvim-web-devicons' },
    },
    event = "VimEnter",
}
