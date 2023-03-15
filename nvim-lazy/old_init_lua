
-- Initialize package manager
-- require("lazy").setup("plugins", "configs")
require("lazy").setup({
    -------------------
    -- Colors
    -------------------
    -- gruvbox-material
    {
        "sainnhe/gruvbox-material",
    },

    -- Solarized colors
    {
        "Tsuzat/NeoSolarized.nvim",
    },
    -- Centers window & Dims inactive regions
    { 'folke/twilight.nvim' },
    { 'folke/zen-mode.nvim' },
    { "p00f/nvim-ts-rainbow" },

    -------------------
    -- Git
    -------------------
    { "tpope/vim-fugitive" },
    { "lewis6991/gitsigns.nvim" },

    -------------------
    -- File Explorer
    -------------------
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = 'v2.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',
            "MunifTanjim/nui.nvim",
        },
	lazy = false,
    },
    { -- better window movement
        's1n7ax/nvim-window-picker',
        version = 'v1.*',
    },

    -- =============================
    -- =    Treesitter
    -- =============================
    { -- Treesitter for highlighting + other goodies
        'nvim-treesitter/nvim-treesitter',
        build = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
    },

    -- =============================
    -- =    LSP Setup
    -- =============================
    { 'j-hui/fidget.nvim' }, -- Status updates for LSP
    {
        'VonHeikemen/lsp-zero.nvim',
        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },


            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    },

    -- =============================
    -- =    Debug Setup (DAP)
    -- =============================
    { -- VSCode like debug UI
        "rcarriga/nvim-dap-ui",
        dependencies = {
            { "mfussenegger/nvim-dap" },
            { "mfussenegger/nvim-dap-python" },
        }
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            -- Debug adapters
            { "nvim-neotest/neotest-python" },
        }
    },


    -- =============================
    -- =    MISC
    -- =============================
    { 'nvim-lualine/lualine.nvim' }, -- Fancier statusline
    { 'lukas-reineke/indent-blankline.nvim' }, -- add indent guides on bank lines
    { 'numToStr/Comment.nvim' }, -- "gc" to comment regions

    -- persistent & powerful undo abilities
    -- { "mbbill/undotree",                    { lazy = true, } },
}, "config")
