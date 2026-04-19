return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
      local opts = {
        formatters_by_ft = {
          javascript = { "prettier" },
          typescript = { "prettier" },
          markdown = { "prettier" },
          css = { "prettier" },
          html = { "prettier" },
          json = { "prettier" },
          -- agrega otros filetypes que quieras
        },
        formatters = {
          prettier = {},
        },
      }
      return opts
    end,
  },
}
