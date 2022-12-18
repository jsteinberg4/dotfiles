-- Packer bootstrapping
-- > Copied from nvim-lua/kickstart.nvim
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.execute('!git clone --depth 1 https://github.com/wbthomason/packer.nvim' .. install_path)
    vim.cmd [[packadd packer.nvim]]
end

-- Install plugins here
-- Equivalent to the Plug#begin section for vim-plug
require("packer").startup(function(use)
    -- Do not remove this -- Installs/uses packer
    use("wbthomason/packer.nvim")

    -- Colors
    use("gruvbox-community/gruvbox")
    use("navarasu/onedark.nvim")

    -- Telescope fuzzy finding files, keymaps, etc.
    use {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        requires = { 'nvim-lua/plenary.nvim' }
    }
    use { -- Faster(?) fuzzy find algorithm
        'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
        cond = vim.fn.executable 'make' == 1
    }

    -- Git integration
    use("tpope/vim-fugitive")
    use("tpope/vim-rhubarb")
    use("lewis6991/gitsigns.nvim")

    use('nvim-lualine/lualine.nvim') -- Fancier statusline
    use('lukas-reineke/indent-blankline.nvim') -- add indent guides on bank lines
    use('numToStr/Comment.nvim') -- "gc" to comment regions
    use('tpope/vim-sleuth') -- autodetect tabstop + shift width

    use("theprimeagen/harpoon") -- pin recent files
    use("mbbill/undotree") -- persistent & powerful undo abilities


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
    use { -- Language server itself
        'neovim/nvim-lspconfig',
        requires = {
            -- Auto install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            -- Useful status updates for LSP
            'j-hui/fidget.nvim',
        },
    }
    use { -- Autocompletion
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',

            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'rafamadriz/friendly-snippets',
        },
    }

    -- =============================
    -- =    Debug Setup -- TODO
    -- =============================



    if is_bootstrap then
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
