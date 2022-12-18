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


    -- Language server stuff



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
