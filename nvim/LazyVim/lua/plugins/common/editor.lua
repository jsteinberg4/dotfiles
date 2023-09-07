-- Fancy editor feature plugins

return {
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
      snippet_engine = "luasnip",
      languages = {
        python = {
          template = {
            annotation_convention = "reST",
          },
        },
      },
    },
    version = "*",
    keys = {
      {
        "<leader>cc",
        function()
          require("neogen").generate({})
        end,
        desc = "Generate docstring ([c]ode [c]omment)",
      },
    },
  },
  {
    -- Code outline sidepanel
    -- https://github.com/simrat39/symbols-outline.nvim#default-keymaps
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = {
      {
        "<leader>co",
        "<cmd>SymbolsOutline<cr>",
        desc = "[c]ode symbols [o]utline",
      },
    },
    config = function(_, opts)
      require("symbols-outline").setup(opts)
    end,
    opts = {
      position = "right",
    },
  },
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  {
    "m4xshen/hardtime.nvim",
    enabled = false,
    event = "BufWinEnter",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = { max_count = 2 },
  },
}
