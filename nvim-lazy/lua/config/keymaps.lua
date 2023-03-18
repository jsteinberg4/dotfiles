--  project tree
-- vim.keymap.set('n', '<leader>pv', vim.cmd.Ex, { desc = "[P]roject [V]iew" })

-- Make space do nothing in normal/vis modes
vim.keymap.set({ 'n', 'v' }, '<Space>', "<Nop>", { silent = true })

-- Add CTRL+S to save b/c of muscle memory for other apps
vim.keymap.set({ 'n', 'v', 'i' }, '<C-s>', vim.cmd.write, { desc = "Save document" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "q", "<Esc>", { desc = "q to exit visual mode" })

-- Join line w/o moving cursor
vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "Q", "<nop>")

-- Use 'q' to cancel visual mode, instead of just Escape
vim.keymap.set("v", "q", "<Esc>")

-- #####################
-- Always keep cursor centered!
-- #####################
vim.keymap.set("n", "gg", "ggzz", { desc = "GOTO top, center cursor" })
vim.keymap.set("n", "G", "Gzz", { desc = "GOTO bottom, center cursor" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Page down, center cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Page up, center cursor" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Keep cursor centered while searching" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Center cursor while searching" })
