-- =============================
-- =    Git plugins
-- =============================

-- From packer version:
-- -- Primary keybind for git fugitive
-- vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [S]tatus" })
return {
    {
        "tpope/vim-fugitive",
        event = { "BufReadPre", "BufNewFile" },
    },
    -- Git signs
    {
        -- Borrowed from LazyVim:
        -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/editor.lua
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            -- Default values for signs:
            -- signs = {
            --     add          = { text = '│' },
            --     change       = { text = '│' },
            --     delete       = { text = '_' },
            --     topdelete    = { text = '‾' },
            --     changedelete = { text = '~' },
            --     untracked    = { text = '┆' },
            -- }
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
            -- My old version from packer setup:
            -- signs = {
            --   add = { text = '+' },
            --   change = { text = '~' },
            --   delete = { text = '_' },
            --   topdelete = { text = '‾' },
            --   changedelete = { text = '~' },
            -- },
            on_attach = function(buffer)
                -- Shorthand mapping function
                local function map(mode, keymap, cmd, desc)
                    vim.keymap.set(mode, keymap, cmd, {
                        buffer = buffer, desc = desc
                    })
                end

                local gs = package.loaded.gitsigns
                -- stylua: ignore start
                map("n", "]h", gs.next_hunk, "Next [h]unk (Modified section)")
                map("n", "[h", gs.prev_hunk, "Prev [h]unk (Modified section)")
                map("n", "<leader>gsb", gs.stage_buffer, "[g]it [s]tage current [b]uffer")
                map({ "n", "v" }, "<leader>ghs", gs.stage_hunk, "[g]it [h]unk [s]ltage")
                map({ "n", "v" }, "<leader>ghr", gs.reset_hunk, "[g]it [h]unk [r]eset")
                map("n", "<leader>ghu", gs.undo_stage_hunk, "[g]it [h]unk [u]nstage")
                map("n", "<leader>gbr", gs.reset_buffer, "[g]it [b]uffer [r]eset")
                map("n", "<leader>gph", gs.preview_hunk, "[g]it [p]review [h]unk")
                map("n", "<leader>gB", function() gs.blame_line({ full = true }) end, "[g]it [b]lame this [l]ine")
                map({ "o", "x" }, "<leader>gsh", ":<C-U>Gitsigns select_hunk<CR>", "[g]it [s]elect [h]unk")
                map("n", "<leader>ghd", gs.diffthis, "[g]it [d]iff [h]unk")
                map("n", "<leader>gdm", function() gs.diffthis("~") end, "[g]it [d]iff [~]head")
                -- map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "[G]it [H]unk [R]eset")
                -- map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "[G]it [H]unk [S]tage")
            end,
        },
    },
}
