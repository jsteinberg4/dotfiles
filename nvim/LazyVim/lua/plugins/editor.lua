-- Fancy editor feature plugins

return {
  {
    -- Code outline sidepanel
    -- https://github.com/simrat39/symbols-outline.nvim#default-keymaps
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>co", "<cmd>SymbolsOutline<cr>", desc = "[c]ode symbols [o]utline" } },
    config = function(_, opts)
      require("symbols-outline").setup(opts)
    end,
    opts = {
      position = "right",
    },
  },
}
