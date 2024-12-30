return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "LazyFile",
    opts = function()
      local tsc = require("treesitter-context")

      ---@diagnostic disable-next-line: missing-fields
      Snacks.toggle({
        name = "Treesitter Context",
        get = tsc.enabled,
        set = function(state)
          if state then
            tsc.enable()
          else
            tsc.disable()
          end
        end,
      }):map("<leader>ut")
      return { mode = "cursor", max_lines = 3, separator = "-" }
    end,
  },
  { "EdenEast/nightfox.nvim" },
  -- Configure LazyVim to load gruvbox
  { -- Default colorscheme
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "duskfox",
      colorscheme = "nordfox",
    },
  },
  {
    "folke/snacks.nvim",
    opts = {
      bigfile = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { folds = { open = true, git_hl = false } },
      words = { enabled = true },
      dashboard = {
        sections = {
          {
            pane = 1,
            section = "terminal",
            cmd = "chafa "
              .. vim.fn.stdpath("data")
              .. "/dashboard.png"
              .. " --format symbols --symbols vhalf --size 60x17  --stretch; sleep .1",
            height = 17,
            padding = 1,
          },
          {
            pane = 2,
            -- { title = "Recent Sessions" },
            -- { section = "session" },
            { title = "Recent Files" },
            { section = "recent_files" },
            { gap = 1 },
            { title = "Recent Projects", padding = 0.5 },
            { section = "projects" },
            { gap = 1 },
            { title = "Bookmarks" },
            { section = "keys", padding = 1 },
          },
          {
            pane = 1,
            icon = " ",
            title = "Git Status",
            section = "terminal",
            enabled = function()
              return Snacks.git.get_root() ~= nil
            end,
            cmd = "git status --short --branch --renames",
            height = 5,
            padding = 1,
            ttl = 5 * 60,
            indent = 3,
          },
          { section = "startup" },
        },
      },
    },
  },
  { -- Use tab to cycle completion ots
    "hrsh7th/nvim-cmp",
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.select_next_item()
          elseif vim.snippet.active({ direction = 1 }) then
            vim.schedule(function()
              vim.snippet.jump(1)
            end)
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif vim.snippet.active({ direction = -1 }) then
            vim.schedule(function()
              vim.snippet.jump(-1)
            end)
          else
            fallback()
          end
        end, { "i", "s" }),
      })
    end,
  },
  {
    -- Config source: https://www.reddit.com/r/neovim/comments/1hhiidm/a_few_nice_fzflua_configurations_now_that_lazyvim/
    "ibhagwan/fzf-lua",
    opts = {
      oldfiles = {
        -- In Telescope, when I used <leader>fr, it would load old buffers.
        -- fzf lua does the same, but by default buffers visited in the current
        -- session are not included. I use <leader>fr all the time to switch
        -- back to buffers I was just in. If you missed this from Telescope,
        -- give it a try.
        include_current_session = true,
      },
      previewers = {
        builtin = {
          -- fzf-lua is very fast, but it really struggled to preview a couple files
          -- in a repo. Those files were very big JavaScript files (1MB, minified, all on a single line).
          -- It turns out it was Treesitter having trouble parsing the files.
          -- With this change, the previewer will not add syntax highlighting to files larger than 100KB
          -- (Yes, I know you shouldn't have 100KB minified files in source control.)
          syntax_limit_b = 1024 * 100, -- 100KB
        },
      },
      -- grep = {
      --   -- One thing I missed from Telescope was the ability to live_grep and the
      --   -- run a filter on the filenames.
      --   -- Ex: Find all occurrences of "enable" but only in the "plugins" directory.
      --   -- With this change, I can sort of get the same behaviour in live_grep.
      --   -- ex: > enable --*/plugins/*
      --   -- I still find this a bit cumbersome. There's probably a better way of doing this.
      --   rg_glob = true, -- enable glob parsing
      --   glob_flag = "--iglob", -- case insensitive globs
      --   glob_separator = "%s%-%-", -- query separator pattern (lua): ' --'
      -- },
    },
  },
}
