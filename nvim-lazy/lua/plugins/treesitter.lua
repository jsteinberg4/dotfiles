-- =============================
-- =    Treesitter
-- =============================
return {
    { -- Treesitter for highlighting + other goodies
        'nvim-treesitter/nvim-treesitter',
        build = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
        },
        keys = {
        },
        opts = {
        },

        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
}
