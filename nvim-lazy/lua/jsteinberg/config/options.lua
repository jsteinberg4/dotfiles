vim.o.autowrite = true -- Autosave
vim.o.backup = false
vim.o.breakindent = true -- Indent any wrapped lines
vim.o.clipboard = "unnamedplus" -- Sync w/ system clipboard
vim.o.conceallevel = 3 -- Hide * markup for bold/italic
-- vim.o.colorcolumn = "80" -- A colored column at x="N"
vim.o.completeopt = "menu,menuone,noselect" -- Set completeopt for better completion experience
vim.o.confirm = true -- Confirm operations instead of failing bc modified buffer
vim.o.cursorline = true -- Highlight current line
vim.o.errorbells = false
vim.o.expandtab = true -- Use spaces instead of tabs
vim.o.formatoptions = "jcroqlnt" -- Default is "tcqj
vim.o.guicursor = ""
vim.o.grepformat = "%f:%l:%c:%m" -- Grep: result formatting
vim.o.grepprg = "rg --vimgrep" -- Grep: Use ripgrep
vim.o.hlsearch = false -- Highlight search results
vim.o.inccommand = "nosplit" -- Preview incremental substitute
vim.o.incsearch = true -- Show results as you type search
vim.o.ignorecase = true -- Case insensitive search
vim.o.laststatus = 0 -- Never show a status line for the last window
vim.o.list = true -- Shows some invisible characters
vim.o.mouse = "nv" -- Enable mouse only in normal & visual modes
vim.o.number = true -- Show absolute line numbers
vim.o.pumblend = 10 -- Popup window transparency
vim.o.pumheight = 10 -- Max # of entries in a popup
vim.o.relativenumber = true -- Show relative line numbers
vim.o.ruler = true -- Shows cursor position in status line
vim.o.scrolloff = 8 -- Show N lines of context around cursor
vim.o.sessionoptions = "buffers,curdir,tabpages,winsize" -- Enables saving/restoring each of these
vim.o.shiftround = true -- Always indent by a multiple of shiftwidth
vim.o.shiftwidth = 2 -- Width of an indent
vim.o.shortmess = "filnxtToOF" .. "WIc" -- Default + extra options. Avoids some extra prompts.
vim.o.showmode = false -- Statusline already shows mode
vim.o.sidescrolloff = 8 -- Horizontal scrolloff. Columns of context
vim.o.signcolumn = "yes" -- Always show sign column
vim.o.smartcase = true -- Search is case sensitive if you use capitals
vim.o.smartindent = true -- Auto insert indents
vim.o.spelllang = "en" -- Languages to spellcheck against
vim.o.splitbelow = true -- Horizontal splits put the new window below
vim.o.splitright = true -- Vertical spolits open new window to the right
vim.o.swapfile = false -- Don't use swap files
vim.o.tabstop = 2 -- Number of spaces to count a tab for
vim.o.termguicolors = true -- True color support
vim.o.timeoutlen = 300 -- Time to wait for keymappings (milliseconds)
-- vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Long term undo directory for undotree
vim.o.undofile = true -- Enables long term undo file
vim.o.updatetime = 50 -- Update files often. Would save swapfile & trigger "CursorHold"
vim.o.wildmode = "longest:full,full" -- Commandline completion mode
vim.o.winminwidth = 5 -- Minimum window width
vim.o.wrap = false -- Do not wrap lines

-- if vim.fn.has("nvim-0.9.0") == 1 then
-- 	vim.o.splitkeep = "screen"
--         vim.o.shortmess::append { C = true }
-- end

-- =============================
-- =    Global options
-- =============================
-- Recommended markdown setting from LazyVim
vim.g.markdown_recommended_style = 0

-- NetRW configs
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Python provider setup
vim.g.python3_host_prog = os.getenv("HOME") .. "/environments/neovim-provider/bin/python3"
