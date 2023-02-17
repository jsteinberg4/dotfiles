vim.o.termguicolors = true

function Theme(background, contrast)
    vim.g.my_colors = "gruvbox-material"

    -- Set to "dark" for dark theme, "light" for light theme
    vim.o.background = background or 'dark'

    -- Should come before setting colorscheme.
    -- Available: 'hard', 'medium', 'soft'
    -- Theme default: 'medium'
    vim.g.gruvbox_material_background = contrast or 'hard'

    -- Allegedly improves performance
    vim.g.gruvbox_material_better_performance = 1

    -- g:gruvbox_material_foreground~
    --
    -- The foreground color palette used in this color scheme.
    --
    -- - `material`: Carefully designed to have a soft contrast.
    -- - `mix`: Color palette obtained by calculating the mean of the other two.
    -- - `original`: The color palette used in the original gruvbox.
    --
    --     Type:               |String|
    --     Available values:   `'material'`, `'mix'`, `'original'`
    --     Default value:      `'material'`
    vim.g.gruvbox_material_foreground = "material"

    -- Set theme
    vim.cmd.colorscheme(vim.g.my_colors)
end

Theme()
