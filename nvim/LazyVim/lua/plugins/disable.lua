-- table of pre-configured plugins from LazyVim/starter to disable

local plugins = {}
local to_disable = {
  -- TODO: Disabling flit, sneak until I have a better keymap to get insert/replace mode back (highlight, s)
  "ggandor/leap.nvim",
  "ggandor/flit.nvim",
  -- "goolord/alpha-nvim",
}

-- Disable every plugin in the `to_disable` list
for _, name in pairs(to_disable) do
  vim.list_extend(plugins, { { name, enabled = false } })
end

return plugins
