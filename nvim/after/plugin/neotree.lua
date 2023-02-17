vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

-- Icons for diagnostic errors
vim.fn.sign_define("DiagnosticSignError",
    { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn",
    { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo",
    { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint",
    { text = "", texthl = "DiagnosticSignHint" })


require('neo-tree').setup({
    -- Close neo-tree if it's the only open window
    close_if_last_window = true,
    sort_case_insensitive = true,
    source_selector = {
        winbar = true,
        statusline = false,
    },
    buffers = {
        follow_current_files = true,
    },
    default_component_configs = {
        container = {
            enable_character_fade = true
        },
        indent = {
            indent_size = 4,
            padding = 2, -- Padding on LHS
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
        },
        icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "ﰊ",
        },
        name = {
            trailing_slash = true,
        },
        git_status = {
            symbols = {}
        },
    },
    window = {},
})

-- Keybindings
vim.keymap.set("n", "<leader>pv", ":NeoTreeFloatToggle<CR>", { desc = "[P]roject [V]iew" })
-- vim.keymap.set("n", "<leader>pv",
--     ":NeoTreeRevealToggle<CR>",
--     { desc = "[P]roject [V]iew" })
