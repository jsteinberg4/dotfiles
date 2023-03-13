-- Note: This setup is adapted from the LazyVim/starer template repository.
--       More info here: https://github.com/LazyVim/starter/

-- ----------------
-- START: Plugin Manager Bootstrapping
-- Plugin Manager: folke/lazy.nvim
-- ----------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath) -- Adds lazy.nvim to NeoVim's path 
-- ----------------
-- END: Plugin Manager Bootstrapping
-- ----------------

-- Set mapleader before ANYTHING else bc of weird bugs
vim.g.mapleader = ' '

require("lazy").setup({
	spec = {
		-- Import any modules, plugins, etc. here. eg: 
		-- { import = "lazyvim.plugins.extras.lang.typescript" },
		-- { import = "lazyvim.plugins.extras.lang.json" },
		-- { import = "lazyvim.plugins.extras.ui.mini-animate" },
		-- import/override with your plugins
		{ import = "plugins" },
	},

	-- Configuration options for lazy.nvim itself
	defaults = {
		-- Lazily load plugins by default
		lazy = true,
		-- Automatically check for plugin updates
		checker = true,
	},
})
