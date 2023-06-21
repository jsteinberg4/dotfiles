return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- Linters
        "pylint",
        "jsonlint",
        "markdownlint",
        "write-good",
        -- Formatters
        "autoflake",
        "black",
        "stylua",
        "usort",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- Any servers here will be automatically installed with mason and loaded with lspconfig
        lua_ls = { -- Lua language server as example
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        bashls = {},
        clangd = {},
        cssls = {},
        html = {},
        -- jsonls = {}, -- WARN: Covered by LazyVim json extras
        marksman = {},
        pyright = {},
        yamlls = {},
      },
      setup = {
        clangd = function(_, opts)
          -- https://www.lazyvim.org/configuration/recipes#fix-clangd-offset-encoding
          opts.capabilities.offsetEncoding = { "utf-16" }
        end,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      -- treesitter parsers
      ensure_installed = {
        "bash",
        "c",
        "css",
        "gitignore",
        "html",
        "javascript",
        "json",
        "jsonc",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml",
      },
    },
  },
}
