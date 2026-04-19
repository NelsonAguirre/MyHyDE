return {
  "kdheepak/lazygit.nvim",
  cmd = "LazyGit",
  -- optional for floating window border decoration
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  -- configure keymap
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
  }
}
