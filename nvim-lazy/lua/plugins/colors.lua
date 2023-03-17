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
    },
    -------------------
    -- Other coloring
    -------------------
    -- Centers window & Dims inactive regions
    { 'folke/twilight.nvim' },
    { 'folke/zen-mode.nvim' },
    { "p00f/nvim-ts-rainbow" },
}
