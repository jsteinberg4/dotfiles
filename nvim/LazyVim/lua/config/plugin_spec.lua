local M = {}

M.base_spec = {
  -- add LazyVim and import its plugins
  { "LazyVim/LazyVim", import = "lazyvim.plugins" },
  { import = "lazyvim.plugins.extras.lang.json" },
  { import = "lazyvim.plugins.extras.lang.clangd" },
  { import = "lazyvim.plugins.extras.lang.python" },
  { import = "lazyvim.plugins.extras.test.core" },
  { import = "lazyvim.plugins.extras.dap.core" },
  { import = "lazyvim.plugins.extras.util.project" },
}
M.optional_langs = {
  { "go", { import = "lazyvim.plugins.extras.lang.go" } },
  { "node", { import = "lazyvim.plugins.extras.lang.typescript" } },
  { "node", { import = "lazyvim.plugins.extras.formatting.prettier" } },
}

---@return string
function M.get_branch()
  local stdout = io.popen("git rev-parse --abbrev-ref HEAD")
  local branch = stdout:read("*a")
  stdout:close()

  return vim.trim(branch)
end

function M.setup()
  local plugs = M.base_spec
  local branch = M.get_branch()

  -- Configure extra languages
  for _, opts in pairs(M.optional_langs) do
    if vim.fn.executable(opts[1]) == 1 then
      vim.list_extend(plugs, { opts[2] })
    end
  end

  -- Include custom configs. Only add work-specific if on the work branch
  vim.list_extend(plugs, { { import = "plugins.common" } })
  if branch == "work" then
    vim.list_extend(plugs, { { import = "plugins.work" } })
  end

  return plugs
end

return M.setup()
