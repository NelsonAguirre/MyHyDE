return {
  {
    "quarto-dev/quarto-nvim",
    ft = { "quarto", "markdown", "md" },
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      local quarto = require("quarto")
      quarto.setup()
      vim.keymap.set(
        "n",
        "<leader>Qop",
        quarto.quartoPreview,
        { silent = true, noremap = true, desc = "[O]pen Quarto Preview" }
      )
      vim.keymap.set(
        "n",
        "<leader>Qcp",
        quarto.quartoClosePreview,
        { silent = true, noremap = true, desc = "[C]lose Quarto Preview" }
      )
    end,
  },
}
