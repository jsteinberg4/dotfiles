vim.g.mapleader = " "
vim.keymap.set("n", "Q", "<nop>")

-- Make space do nothing in normal/vis modes
vim.keymap.set({ 'n', 'v' }, '<Space>', "<Nop>", { silent = true })

-- Vertical split project tree
vim.keymap.set('n', '<leader>pt', vim.cmd.Vexplore, { desc = "[P]roject [T]ree" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Page down, center cursor" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Page up, center cursor" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Keep cursor centered while searching" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Center cursor while searching" })

