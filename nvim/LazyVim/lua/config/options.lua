-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.o
local global = vim.g

----------------------------------------------
-----------------globals----------------------
----------------------------------------------
-- Recommended markdown setting from LazyVim
global.markdown_recommended_style = 0
global.python3_host_prog = os.getenv("HOME") .. "/environments/neovim-provider/bin/python3"
global.loaded_perl_provider = 0
global.loaded_ruby_provider = 0

-- NetRW Conf
global.netrw_keepdir = 0 -- Keep current & browsing dir synced
global.netrw_browse_split = 0
global.netrw_banner = 0
global.netrw_winsize = 30
global.netrw_localcopydircmd = "cp -r"

----------------------------------------------
----------------options-----------------------
----------------------------------------------
opt.autowrite = true -- Autosave
opt.backup = false
opt.breakindent = true -- Indent any wrapped lines
opt.clipboard = "unnamedplus" -- Sync w/ system clipboard
opt.conceallevel = 3 -- Hide * markup for bold/italic
opt.colorcolumn = "88" -- A colored column at x="N"
opt.completeopt = "menu,menuone,noselect" -- Set completeopt for better completion experience
opt.confirm = true -- Confirm operations instead of failing bc modified buffer
opt.cursorline = true -- Highlight current line
opt.errorbells = false
opt.expandtab = true -- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" -- Default is "tcqj
opt.guicursor = ""
opt.guifont = "JetBrainsMono Nerd Font"
opt.grepformat = "%f:%l:%c:%m" -- Grep: result formatting
opt.grepprg = "rg --vimgrep" -- Grep: Use ripgrep
opt.hlsearch = false -- Highlight search results
opt.inccommand = "nosplit" -- Preview incremental substitute
opt.incsearch = true -- Show results as you type search
opt.ignorecase = true -- Case insensitive search
opt.laststatus = 0 -- Never show a status line for the last window
opt.list = true -- Shows some invisible characters
opt.mouse = "nv" -- Enable mouse only in normal & visual modes
opt.number = true -- Show absolute line numbers
opt.pumblend = 10 -- Popup window transparency
opt.pumheight = 10 -- Max # of entries in a popup
opt.relativenumber = true -- Show relative line numbers
opt.ruler = true -- Shows cursor position in status line
opt.scrolloff = 3 -- Show N lines of context around cursor
opt.sessionoptions = "buffers,curdir,tabpages,winsize" -- Enables saving/restoring each of these
opt.shiftround = true -- Always indent by a multiple of shiftwidth
opt.shiftwidth = 2 -- Width of an indent
opt.shortmess = "filnxtToOF" .. "WIc" -- Default + extra options. Avoids some extra prompts.
opt.showmode = false -- Statusline already shows mode
opt.sidescrolloff = 8 -- Horizontal scrolloff. Columns of context
opt.signcolumn = "yes" -- Always show sign column
opt.smartcase = true -- Search is case sensitive if you use capitals
opt.smartindent = true -- Auto insert indents
opt.spelllang = "en" -- Languages to spellcheck against
opt.splitbelow = true -- Horizontal splits put the new window below
opt.splitright = true -- Vertical spolits open new window to the right
opt.swapfile = false -- Don't use swap files
opt.tabstop = 2 -- Number of spaces to count a tab for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300 -- Time to wait for keymappings (milliseconds)
-- opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Long term undo directory for undotree
opt.undofile = true -- Enables long term undo file
opt.updatetime = 300 -- Update files often. Would save swapfile & trigger "CursorHold"
opt.wildmode = "longest:full,full" -- Commandline completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Do not wrap lines
