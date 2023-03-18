-- =============================
-- =    Telescope.nvim
-- =============================

return {
    'nvim-telescope/telescope.nvim',
    cmd = "Telescope",
    version = false,
    init = function() -- FIXME: check if this even works
        -- TODO: Incorporate extensions
        pcall(require('telescope').load_extension, 'fzf')
    end,
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        {
            -- Faster(?) fuzzy find algorithm
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make',
            cond = vim.fn.executable 'make' == 1,
            cmd = "Telescope",
        },
        { 'nvim-tree/nvim-web-devicons' },
    },
    opts = {
        -- Config options
        defaults = {
            winblend = 15,          -- Floating window transparency
            path_display = "smart", -- Only show path differneces
            -- From LazyVim:
            prompt_prefix = " ",
            selection_caret = " ",
        },
        mappings = {
            -- Normal mode mappings
            n = {
                ["q"] = function(...)
                    return require("telescope.actions").close(...)
                end,
            },
            -- Insert mode mappings
            i = {
                ["<c-t>"] = function(...)
                    return require("trouble.providers.telescope").open_with_trouble(...)
                end,
                ["<a-t>"] = function(...)
                    return require("trouble.providers.telescope").open_selected_with_trouble(...)
                end,
                ["<a-i>"] = function()
                    Util.telescope("find_files", { no_ignore = true })()
                end,
                ["<a-h>"] = function()
                    Util.telescope("find_files", { hidden = true })()
                end,
                ["<C-Down>"] = function(...)
                    return require("telescope.actions").cycle_history_next(...)
                end,
                ["<C-Up>"] = function(...)
                    return require("telescope.actions").cycle_history_prev(...)
                end,
                ["<C-f>"] = function(...)
                    return require("telescope.actions").preview_scrolling_down(...)
                end,
                ["<C-b>"] = function(...)
                    return require("telescope.actions").preview_scrolling_up(...)
                end,
            },
        },
    },
    keys = { -- Keymaps
        -- Holdover from prev config. iffy difference on grep cmds
        -- -- Note :: ripgrep must be installed for this
        -- vim.keymap.set("n", "<leader>sw", function()
        --    builtin.grep_string({ search = vim.fn.input("Grep >") });
        -- end, { desc = "[S]earch [W]ord" })
        {
            "<leader>/",
            function()
                require("telescope.builtin").current_buffer_fuzzy_find(
                    require("telescope.themes").get_dropdown({ previewer = false })
                )
            end,
            desc = "[/] Fuzzily search in current buffer]",
        },
        {
            "<leader>?", function() require("telescope.builtin").oldfiles() end, desc = "[?] Find recently opened files",
        },
        {
            "<leader>sf", function() require("telescope.builtin").find_files() end, desc = "[S]earch [F]iles"
        },
        {
            "<leader>sg", function() require("telescope.builtin").git_files() end, desc = "[S]earch [G]it files",
        },
        {
            "<leader>sh", function() require("telescope.builtin").help_tags() end, desc = "[S]earch [H]elp"
        },
        {
            "<leader>sl", function() require("telescope.builtin").live_grep() end, desc = "[S]earch [L]ive by grep"
        },
        {
            "<leader>sd", function() require("telescope.builtin").diagnostics() end, desc = "[S]earch [D]iagnostics"
        },
        {
            "<leader>sk", function() require("telescope.builtin").keymaps() end, desc = "[S]earch [K]eymaps"
        },
    },
}
