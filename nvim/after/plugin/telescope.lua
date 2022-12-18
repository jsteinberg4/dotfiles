require('telescope').setup({
   defaults = {
      winblend = 25, -- Floating window transparency
      path_display = "smart", -- Only show path differneces
   }
})
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
local builtin = require('telescope.builtin')

vim.keymap.set("n", "<leader>/", function()
   builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      previewer = false
   })
end, { desc = "[/] Fuzzily search in current buffer]" })

vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sl", builtin.live_grep, { desc = "[S]earch [L]ive by grep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })

-- Note :: ripgrep must be installed for this
vim.keymap.set("n", "<leader>sw", function()
   builtin.grep_string({ search = vim.fn.input("Grep >") });
end, { desc = "[S]earch [W]ord" })
