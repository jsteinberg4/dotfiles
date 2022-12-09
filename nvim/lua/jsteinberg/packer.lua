-- Bootstrap Packer
local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end
local packer_bootstrap = ensure_packer()

-- Install plugins here
-- Equivalent to the Plug#begin section for vim-plug
return require("packer").startup(function(use)
	-- Do not remove this use msg
    use("wbthomason/packer.nvim")

    -- Simple plugins can be specified as strings
    use("tpope/vim-fugitive")

    -- TODO -- What are these for?
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope.nvim")

    -- Status line
    use({
        'nvim-lualine/lualine.nvim',
    })

    -- Colorscheme section
    use("gruvbox-community/gruvbox")
    use("folke/tokyonight.nvim")

    -- Automatically set up fonf after cloning packer. Keep at the end.
    if packer_bootstrap then
	    require('packer').sync()
    end
end)
