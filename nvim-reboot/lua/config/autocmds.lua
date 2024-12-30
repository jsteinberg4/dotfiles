-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Remember code folds
vim.api.nvim_create_augroup("RememberFolds", {})
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "*",
  command = "silent! loadview",
  group = "RememberFolds",
})
vim.api.nvim_create_autocmd("BufWinLeave", {
  pattern = "*",
  command = "silent! mkview",
  group = "RememberFolds",
})

vim.api.nvim_create_augroup("Frankenstein", {})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "/Users/jesse/Repos/frankenstein/**/*.py",
  desc = "Load editorconfig for Frankenstein",
  group = "Frankenstein",
  callback = function(event)
    if not vim.b.editorconfig then
      vim.notify("No EditorConfig properties applied to this buffer.", vim.log.levels.WARN)
      return
    end

    vim.notify("Loaded EditorConfig: " .. vim.inspect(vim.b.editorconfig), vim.log.levels.INFO)

    -- Set colorcolumn based on editorconfig
    if vim.b.editorconfig.max_line_length then
      vim.wo.colorcolumn = vim.b.editorconfig.max_line_length
    end

    -- Disable black autoformatting
    if LazyVim.format.enabled(event.buf) then
      vim.b.autformat = false
      vim.notify("Disabled autoformatting for this buffer.", vim.log.levels.INFO)
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = "/Users/jesse/Repos/frankenstein/**/*.py",
  desc = "Enable editorconfig for Frankenstein project",
  group = "Frankenstein",
  command = "",
  -- callback = function(ev)
  --   local ec = vim.b.editorconfig
  --   if not ec then
  --     vim.notify("No EditorConfig properties applied to this buffer.", vim.log.levels.WARN)
  --     return
  --   end
  --
  --   -- Apply indent size and style
  --   if ec.indent_style == "space" then
  --     vim.bo.expandtab = true
  --   elseif ec.indent_style == "tab" then
  --     vim.bo.expandtab = false
  --   end
  --   if ec.indent_size then
  --     local indent_size = tonumber(ec.indent_size) or 4 -- Default to 4 if not specified
  --     vim.bo.shiftwidth = indent_size
  --     vim.bo.softtabstop = indent_size
  --     if ec.indent_size ~= "tab" then
  --       vim.bo.tabstop = indent_size
  --     end
  --   end
  --
  --   -- Apply maximum line length
  --   if ec.max_line_length then
  --     vim.bo.textwidth = tonumber(ec.max_line_length) or 0
  --   end
  --
  --   -- Apply trailing whitespace trimming
  --   if ec.trim_trailing_whitespace == "true" then
  --     vim.cmd([[
  --           autocmd BufWritePre <buffer> %s/\s\+$//e
  --       ]])
  --   end
  --
  --   -- Apply final newline insertion
  --   if ec.insert_final_newline == "true" then
  --     vim.bo.fixendofline = true
  --   elseif ec.insert_final_newline == "false" then
  --     vim.bo.fixendofline = false
  --   end
  --
  --   vim.notify("Formatted buffer according to EditorConfig.", vim.log.levels.INFO)
  -- end
})
