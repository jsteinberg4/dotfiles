return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
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
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- treesitter parsers
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "c",
        "css",
        "gitignore",
        "html",
        "javascript",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "vim",
        "vimdoc",
        "yaml",
      })
    end,
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
        pyright = {
          settings = {
            python = {
              venvPath = os.getenv("HOME") .. "/environments/",
            },
          },
        },
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
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources, {
        -- Completion
        nls.builtins.completion.spell,
        -- Code Action
        nls.builtins.code_actions.gitsigns,
        -- Diagnostics
        nls.builtins.diagnostics.jsonlint,
        nls.builtins.diagnostics.markdownlint,
        nls.builtins.diagnostics.ruff,
        -- nls.builtins.diagnostics.pylint.with({
        --   extra_args = {
        --     "--generated-members=numpy.*, torch.*",
        --     "--disable=missing-class-docstring,missing-function-docstring,line-too-long,logging-fstring-interpolation,wrong-import-order,pointless-string-statement,broad-except",
        --     "--extension-pkg-whitelist=pydantic",
        --   },
        -- }),
        nls.builtins.diagnostics.write_good, -- "English prose linter"
        -- Formatters
        nls.builtins.formatting.autoflake,
        nls.builtins.formatting.black,
        nls.builtins.formatting.stylua,
        -- Hover
        nls.builtins.hover.dictionary, -- Definitions
        nls.builtins.hover.printenv, -- Show env values
      })
    end,
  },
}
