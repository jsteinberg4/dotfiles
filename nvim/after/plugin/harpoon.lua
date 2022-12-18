local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "[H]arpoon [A]dd" })
vim.keymap.set("n", "<leader>hp", ui.toggle_quick_menu, { desc = "[H]ar[p]oon" })
vim.keymap.set("n", "<leader>hd", mark.rm_file, { desc = "[H]arpoon [R]emove" })

vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end, { desc = "Harpoon Page #1" })
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end, { desc = "Harpoon Page #2" })
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end, { desc = "Harpoon Page #3" })
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end, { desc = "Harpoon Page #4" })
