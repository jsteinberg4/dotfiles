return {
  {
    -- NOTE: Disables default tab, s-tab behavior in Luasnip
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  { -- NOTE: Hole section taken directly from https://www.lazyvim.org/configuration/recipes#supertab
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- this way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        -- Linters
        "jsonlint",
        "markdownlint",
        "write-good",
        -- Formatters
        "black",
        "stylua",
        "usort",
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = { "nvim-treesitter/nvim-treesitter-context" },
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
        bashls = {},
        cssls = {},
        html = {},
        marksman = {},
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
      },
    },
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources, {
        -- Completion
        -- Code Action
        nls.builtins.code_actions.gitsigns,
        -- Diagnostics
        nls.builtins.diagnostics.jsonlint,
        nls.builtins.diagnostics.markdownlint,
        nls.builtins.diagnostics.pylint.with({
          extra_args = {
            "--generated-members=numpy.*, torch.*",
            "--disable=missing-class-docstring,missing-function-docstring,line-too-long,logging-fstring-interpolation,wrong-import-order,pointless-string-statement,broad-except",
            "--extension-pkg-whitelist=pydantic",
          },
        }),
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
