return {
  { "EdenEast/nightfox.nvim" },
  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "duskfox",
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
      scroll = {
        animate = { step = 10 },
      },
      statuscolumn = { folds = { open = true, git_hl = false } },
      words = { enabled = true },

      dashboard = {
        sections = {
          {
            pane = 1,
            section = "terminal",
            cmd = "chafa ~/Pictures/Doris_Face_Pink.png --format symbols --symbols vhalf --size 60x17  --stretch; sleep .1",
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
}
