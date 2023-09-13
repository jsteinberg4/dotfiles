-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Remember code folds on exit
augroup("RememberFolds", {})
autocmd("BufWinEnter", {
  pattern = "*",
  command = "silent! loadview",
  group = "RememberFolds",
})
autocmd("BufWinLeave", {
  pattern = "*",
  command = "silent! mkview",
  group = "RememberFolds",
})

-- WARN: Disable virtual text in python files
augroup("DisableVirtText", {})
autocmd("BufWinEnter", {
  pattern = { "*.py", "*.c", "*.h" },
  command = "lua vim.diagnostic.config({virtual_text = false})",
  group = "DisableVirtText",
})
autocmd("BufWinLeave", {
  pattern = { "*.py", "*.c", "*.h" },
  command = "lua vim.diagnostic.config({virtual_text = true})",
  group = "DisableVirtText",
})
