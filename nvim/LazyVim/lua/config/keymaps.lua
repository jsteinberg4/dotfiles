-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local Util = require("lazyvim.util")

local function map(mode, lhs, func, opts)
  local keys = require("lazy.core.handler").handlers.keys

  ---@cast keys LazyKeysHandler do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, func, opts)
  end
end

map("n", "J", "mzJ`z", { desc = "Join lines w/o moving cursor" })
map("n", "gg", "ggzz", { desc = "GOTO top, center cursor" })
map("n", "G", "Gzz", { desc = "GOTO bottom, center cursor" })
map("n", "<C-d>", "<C-d>zt", { desc = "Page down, top cursor" })
map("n", "<C-u>", "<C-u>zt", { desc = "Page up, top cursor" })
map("n", "n", "nztzv", { desc = "Keep cursor centered while searching" })
map("n", "N", "Nztzv", { desc = "Center cursor while searching" })

-- Moving lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected line down", silent = true })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected line up", silent = true })

-- File explorer
map("n", "<leader>pv", "<CMD>Explore %:p:h<CR>", { desc = "[p]roject [v]iew", silent = true })
