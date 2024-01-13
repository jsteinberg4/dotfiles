-- return { -- old/simpler version
--   { "shaunsingh/nord.nvim", event = "VeryLazy" },
--   { "sainnhe/gruvbox-material", event = "VeryLazy" },
--   { "catppuccin", event = "VeryLazy" },
--   { "folke/tokyonight.nvim", event = "VeryLazy" },
--   { "nyoom-engineering/oxocarbon.nvim", event = "VeryLazy" },
--   { "LazyVim/LazyVim", opts = { colorscheme = "catppuccin-frappe" } },
-- }

local M = {}

M.default = {
  plug_path = "nyoom-engineering/oxocarbon.nvim",
  colorscheme = "tokyonight-night",
}

M.colors = {
  "shaunsingh/nord.nvim",
  "sainnhe/gruvbox-material",
  "catppuccin",
  "nyoom-engineering/oxocarbon.nvim",
  "folke/tokyonight.nvim",
}

M.setup = function()
  local plugs = {}

  for _, color in ipairs(M.colors) do
    local color_opts = { color }

    -- Load the default scheme early. Delay all others.
    if color == M.default.plug_path then
      color_opts.event = "VeryLazy"
    else
      -- FIXME: make lazier-loading colors work...somehow
      -- color_opts.keys = { "<leader>uC", "<NOP>", desc = "NOP to load colors" }
      color_opts.event = "VeryLazy"
    end

    vim.list_extend(plugs, { color_opts })
  end

  vim.list_extend(plugs, {
    { "LazyVim/LazyVim", opts = { colorscheme = M.default.colorscheme } },
  })

  return plugs
end

return M.setup()
