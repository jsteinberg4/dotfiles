-- =============================
-- =    Neo-tree.nvim
-- =============================

return {
    "nvim-neo-tree/neo-tree.nvim",
    cmd = "Neotree", -- Load when the Neotree command is called
    branch = "v2.x",
    dependencies = {
        'nvim-lua/plenary.nvim',
        "MunifTanjim/nui.nvim",
        'nvim-tree/nvim-web-devicons',
    },
    init = function()
        vim.g.neo_tree_remove_legacy_commands = 1

        -- Icons for diagnostic errors
        vim.fn.sign_define("DiagnosticSignError",
            { text = " ", texthl = "DiagnosticSignError" })
        vim.fn.sign_define("DiagnosticSignWarn",
            { text = " ", texthl = "DiagnosticSignWarn" })
        vim.fn.sign_define("DiagnosticSignInfo",
            { text = " ", texthl = "DiagnosticSignInfo" })
        vim.fn.sign_define("DiagnosticSignHint",
            { text = "", texthl = "DiagnosticSignHint" })

        if vim.fn.argc() == 1 then
            local stat = vim.loop.fs_stat(vim.fn.argv(0))
            if stat and stat.type == "directory" then
                require("neo-tree")
            end
        end
    end,
    deactivate = function()
        vim.cmd([[Neotree close]])
    end,
    keys = {
        {
            "<leader>fe",
            ":silent! Neotree<CR>",
            -- require('neo-tree.command').execute({
            --     toggle = true,
            --     dir = vim.loop.cwd(),
            -- }),
            desc = "[F]ile [E]xplorer (cwd)",
        },
        { "<leader>E", "<leader>fE", desc = "[E]xplorer (cwd)", remap = true },
    },
    opts = {
        -- Note: Run `:lua require('neo-tree').paste_default_config()` in an emtpy
        --       buffer to see the full default configuration
        sort_case_insensitive = true,
        hijack_netrw_behavior = "open_default",
        source_selector = { winbar = false, statusline = true },
        buffers = { follow_current_files = true },
        default_component_configs = {
            container = { enable_character_fade = true },
            name = { trailing_slash = true },
            indent = {
                with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                indent_size = 4,
                padding = 2,           -- Padding on LHS
                expander_collapsed = "",
                expander_expanded = "",
                expander_highlight = "NeotreeExpander",
            },
            -- icon = {
            --     folder_closed = "",
            --     folder_open = "",
            --     folder_empty = "ﰊ",
            -- },
        },
        window = {
            mappings = {
                ["<space>"] = "none",
            },
        },
        filesystem = {
            bind_to_cwd = false,
            follow_current_file = true,
            -- For async_directory_scan:
            -- "auto"   means refreshes are async, but it's synchronous when called from the Neotree commands.
            -- "always" means directory scans are always async.
            -- "never"  means directory scans are never async.
            async_directory_scan = "always",
            filtered_items = {
                visible = false,
                hide_gitignored = true,
                hide_hidden = true,
                hide_by_name = {
                    ".DS_Store",
                    "__pycache__",
                },
            },
        },
        event_handlers = {
            {
              -- Close Neotree after opening a file
                event = "file_opened",
                handler = function(file_path)
                    require("neo-tree").close_all()
                end
            },
            {
                -- Equalize window sizes after opening neo-tree
                event = "neo_tree_window_after_open",
                handler = function(args)
                    if args.position == "left" or args.position == "right" then
                        vim.cmd("wincmd =")
                    end
                end
            },
            {
                -- Equalize window sizes after closing neo-tree
                event = "neo_tree_window_after_close",
                handler = function(args)
                    if args.position == "left" or args.position == "right" then
                        vim.cmd("wincmd =")
                    end
                end
            },
        },
        -- These options are for people with VERY large git repos
        -- I need these for work.
        git_status_async_options = {
            batch_size = 1000, -- how many lines of git status results to process at a time
            batch_delay = 10,  -- delay in ms between batches. Spreads out the workload to let other processes run.
            -- How many lines of git status results to process. Anything after this will be dropped.
            -- Anything before this will be used. The last items to be processed are the untracked files.
            max_lines = 10000,
        },
    },
}
