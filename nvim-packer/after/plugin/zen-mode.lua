-- ####################################
-- Configurations for folke/twilight.nvim and folke/zen-mode.nvim
-- ####################################

-- ####################################
-- Config: folke/zen-mode.nvim
-- ####################################
require('zen-mode').setup({
    -- Callback for when Zen Mode opens
    on_open = function(win)
    end,
    -- Callback when zenmode closes
    on_close = function()
    end,
})

-- ####################################
-- Config: folke/twilight.nvim
-- ####################################
-- Automatically triggered with ZenMode
require('twilight').setup({
    inactive = true,
    exclude = { -- Filetypes to exclude (file extension)
        'txt',
        'md',
    }
})


-- ####################################
-- Keymaps
-- ####################################
vim.keymap.set('n', '<leader>tz',
    '<CMD>silent ZenMode<CR>',
    { desc = 'Toggle [T]oggle [Z]en-mode' }
)
