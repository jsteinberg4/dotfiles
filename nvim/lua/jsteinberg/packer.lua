-- Packer bootstrapping
-- > Copied from nvim-lua/kickstart.nvim
-- local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
-- local is_bootstrap = false
-- if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
--     is_bootstrap = true
--     vim.fn.execute('!git clone --depth 1 https://github.com/wbthomason/packer.nvim' .. install_path)
--     vim.cmd [[packadd packer.nvim]]
-- end
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- Install plugins here
-- Equivalent to the Plug#begin section for vim-plug
require("packer").startup(function(use)
    -- Do not remove this -- Installs/uses packer
    use("wbthomason/packer.nvim")

    -- Colors
    use("sainnhe/gruvbox-material")
    use("navarasu/onedark.nvim")
    use('NLKNguyen/papercolor-theme') -- high contrast

    -- Telescope fuzzy finding files, keymaps, etc.
    use {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { -- Faster(?) fuzzy find algorithm
                'nvim-telescope/telescope-fzf-native.nvim',
                run = 'make',
                cond = vim.fn.executable 'make' == 1
            },
            { 'nvim-tree/nvim-web-devicons' },
        },
    }
    -- Git integration
    use("tpope/vim-fugitive")
    use("tpope/vim-rhubarb")
    use("lewis6991/gitsigns.nvim")

    use('nvim-lualine/lualine.nvim') -- Fancier statusline
    use('lukas-reineke/indent-blankline.nvim') -- add indent guides on bank lines
    use('numToStr/Comment.nvim') -- "gc" to comment regions
    use('tpope/vim-sleuth') -- autodetect tabstop + shift width

    use("mbbill/undotree") -- persistent & powerful undo abilities

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = 'v2.x',
        requires = {
            'nvim-lua/plenary.nvim',
            'nvim-tre/nvim-web-devicons',
            "MunifTanjim/nui.nvim",
        }
    }

    use { -- better window movement
        's1n7ax/nvim-window-picker',
        tag = 'v1.*',
    }

    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })

    -- Language server stuff
    use { -- Treesitter for highlighting + other goodies
        'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
    }

    -- =============================
    -- =    LSP Setup
    -- =============================
    -- Status updates for LSP
    use('j-hui/fidget.nvim')
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
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
    }
    -- =============================
    -- =    Debug Setup (DAP)
    -- =============================
    use { -- VSCode like debug UI
        "rcarriga/nvim-dap-ui",
        requires = {
            { "mfussenegger/nvim-dap" },
            { "mfussenegger/nvim-dap-python" },
        }
    }
    use {
        "nvim-neotest/neotest",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            -- Debug adapters
            { "nvim-neotest/neotest-python" },
        }
    }

    if packer_bootstrap then
        require('packer').sync()
    end

end)

if is_bootstrap then
    print '=================================='
    print '    Plugins are being installed'
    print '    Wait until Packer completes,'
    print '       then restart nvim'
    print '=================================='
    return
end


-- Automatically source and re-compile this file whenever it's saved
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | PackerCompile',
    group = packer_group,
    pattern = vim.fn.expand '$MYVIMRC',
})
