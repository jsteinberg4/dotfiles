-- =============================
-- =    Plugins for changing colors
-- - =============================

return {
    -------------------
    -- Colors
    -------------------
    -- gruvbox-material
    {
        "sainnhe/gruvbox-material",
    },
    -- NeoSolarized
    {
        "Tsuzat/NeoSolarized.nvim",
    },
    -- folke/tokyonight
    {
        -- Borrowed from
        -- https://github.com/folke/dot/blob/master/nvim/lua/plugins/colorscheme.lua
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = function()
            return {
                style = "night",
            }
        end,
        on_highlights = function(hl, c)
            hl.CursorLineNr = { fg = c.orange, bold = true }
            hl.LineNr = { fg = c.orange, bold = true }
            hl.LineNrAbove = { fg = c.fg_gutter }
            hl.LineNrBelow = { fg = c.fg_gutter }
            local prompt = "#2d3149"
            hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg_dark }
            hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
            hl.TelescopePromptNormal = { bg = prompt }
            hl.TelescopePromptBorder = { bg = prompt, fg = prompt }
            hl.TelescopePromptTitle = { bg = c.fg_gutter, fg = c.orange }
            hl.TelescopePreviewTitle = { bg = c.bg_dark, fg = c.bg_dark }
            hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark }
        end,
    },
    -------------------
    -- Other coloring
    -------------------
    -- Centers window & Dims inactive regions
    { 'folke/twilight.nvim' },
    { 'folke/zen-mode.nvim' },
    { "p00f/nvim-ts-rainbow" },
}
