return {
  "KuantumQuest/luasnip-latex",
  branch = "RamaDeSolucion",
  requires = {
    "L3MON4D3/LuaSnip",
    "lervag/vimtex",
  },
  config = function()
    require("luasnip-latex").setup({
      use_treesitter = true,
      allow_on_markdown= true,
    })
  end,
}
