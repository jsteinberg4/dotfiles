vim.o.guicursor = ""

-- Line numbering
vim.o.nu = true
vim.o.relativenumber = true
vim.o.ruler = true -- Shows cursor position in status line

-- Disable mouse
vim.o.mouse = 'n'

vim.o.errorbells = false

-- Text formatting
vim.o.tabstop = 4
-- vim.o.softtabstop = 4
-- vim.o.shiftwidth = 4
-- vim.o.expandtab = true
vim.o.breakindent = true

vim.o.smartindent = true

vim.o.wrap = false

-- Turn off backups & make long term undo tree
-- available to treesitter
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.o.undofile = true

-- Searching
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true
vim.o.hlsearch = false

-- Use terminal colors
vim.o.termguicolors = true

vim.o.scrolloff = 8
vim.o.signcolumn = "yes"

vim.o.updatetime = 50 -- Update files often

vim.o.colorcolumn = "80"

-- Set completeopt for better completion experience
vim.o.completeopt = 'menuone,noselect'


-- NetRW configs
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Python provider setup
vim.g.python3_host_prog = '/Users/jesse/environments/neovim-provider/bin/python3'
