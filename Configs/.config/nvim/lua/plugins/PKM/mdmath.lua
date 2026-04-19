return {
  "Thiago4532/mdmath.nvim",
  enabled = true,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    filetypes = { "markdown", "tex" },
    dynamic_scale = 0.7,
  },
  -- The build is already done by default in lazy.nvim, so you don't need
  -- the next line, but you can use the command `:MdMath build` to rebuild
  -- if the build fails for some reason.
  -- build = ':MdMath build'
}
