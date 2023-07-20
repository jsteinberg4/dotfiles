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
})
autocmd("BufWinLeave", {
  pattern = "*",
  command = "silent! mkview",
})

-- WARN: Disable virtual text in python files
augroup("DisablePyDiagnostics", {})
autocmd("BufWinEnter", {
  pattern = "*.py",
  command = "lua vim.diagnostic.config({virtual_text = false})",
})
autocmd("BufWinLeave", {
  pattern = "*.py",
  command = "lua vim.diagnostic.config({virtual_text = true})",
})
