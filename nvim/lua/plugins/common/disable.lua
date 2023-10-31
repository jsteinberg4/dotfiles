-- table of pre-configured plugins from LazyVim/starter to disable

local plugins = {}
local to_disable = {
  -- "ggandor/leap.nvim",
  -- "ggandor/flit.nvim",
  "goolord/alpha-nvim",
  "nvim-neo-tree/neo-tree.nvim",
  "rcarriga/nvim-notify",
}
--
-- Disable every plugin in the `to_disable` list
for _, name in pairs(to_disable) do
  vim.list_extend(plugins, { { name, enabled = false } })
end

return plugins
