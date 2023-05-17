local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on Yank
augroup("HighlightYank", { clear = true })
autocmd('TextYankPost', {
    group = 'HighlightYank',
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- Remember code folds on exit
augroup('RememberFolds', {})
autocmd('BufWinEnter', {
    pattern = '*',
    command = 'silent! loadview',
})
autocmd('BufWinLeave', {
    pattern = '*',
    command = 'silent! mkview',
})


-- Terminal Settings
-------------------
-- Open term in right tab
autocmd('CmdlineEnter', {
    command = 'command! Term :botright vsplit term://$SHELL',
})

-- Enter insert mode on open term
autocmd('TermOpen', {
    command = 'setlocal listchars= nonumber norelativenumber nocursorline'
})
autocmd('TermOpen', {
    pattern = '',
    command = 'startinsert',
})
