vim.o.termguicolors = true

vim.g.default_colors = "NeoSolarized"

function Gruvbox(contrast)
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
end

function Solarized()
    -- Default value is "normal", Setting this option to "high" or "low" does use the
    -- same Solarized palette but simply shifts some values up or down in order to
    -- expand or compress the tonal range displayed.
    vim.g.neosolarized_contrast = "high"

    -- Special characters such as trailing whitespace, tabs, newlines, when displayed
    -- using ":set list" can be set to one of three levels depending on your needs.
    -- Default value is "normal". Provide "high" and "low" options.
    vim.g.neosolarized_visibility = "high"

    -- I make vertSplitBar a transparent background color. If you like the origin
    -- solarized vertSplitBar style more, set this value to 0.
    vim.g.neosolarized_vertSplitBgTrans = 1

    -- If you wish to enable/disable NeoSolarized from displaying bold, underlined
    -- or italicized" typefaces, simply assign 1 or 0 to the appropriate variable.
    -- Default values:
    vim.g.neosolarized_bold = 1
    vim.g.neosolarized_underline = 1
    vim.g.neosolarized_italic = 0

    -- Used to enable/disable "bold as bright" in Neovim terminal. If colors of bold
    -- text output by commands like `ls` aren't what you expect, you might want to
    -- try disabling this option. Default value:
    vim.g.neosolarized_termBoldAsBright = 1
end

function Theme(name, background, contrast)
    -- Set to "dark" for dark theme, "light" for light theme
    vim.o.background = background or 'dark'
    default = Solarized

    if name == 'NeoSolarized' then
        Solarized()
    elseif name == 'gruvbox-material' then
        Gruvbox(contrast)
    else
        name = vim.g.default_colors
        default()
    end


    -- Set theme
    vim.cmd.colorscheme(name)
end

Theme()
