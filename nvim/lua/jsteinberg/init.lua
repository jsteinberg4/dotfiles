-- Set mapleader before ANYTHING else bc of weird bugs
vim.g.mapleader = ' '

require("jsteinberg.packer")
require("jsteinberg.remap")
require("jsteinberg.set")

local yank_group = vim.api.nvim_create_augroup("HighlightYank", {})

vim.api.nvim_create_autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})
