function ColorMyPencils(color)
    -- Sets the color scheme with a default
    vim.g.my_colors = color or "gruvbox"
    vim.cmd.colorscheme(vim.g.my_colors)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencils()
