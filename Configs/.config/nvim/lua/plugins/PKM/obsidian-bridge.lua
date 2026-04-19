return {
  "oflisback/obsidian-bridge.nvim",
  enabled=false,
  opts = {
    -- your config here
    scroll_sync=false,
  },
  event = {
    "BufReadPre *.md",
    "BufNewFile *.md",
  },
  lazy = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
