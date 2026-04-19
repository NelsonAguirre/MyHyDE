-- return {
--   "nvim-treesitter/nvim-treesitter",
--   branch = 'master',
--   lazy = false,
--   build = ":TSUpdate",
--   config = function()
--     require("nvim-treesitter.configs").setup({
--       -- ignore_install = { "latex" },
--       -- Configuración para cambiar el color de negrita y cursiva, la continuación de esta configuración está en lazy.lua
--       highlight = {
--         enable = true,
--         additional_vim_regex_highlighting = false,
--         custom_captures = {
--           -- Conecta las capturas de negrita con tu grupo de resaltado personalizado
--           ["strong"] = "BoldText",
--           disable = { "latex", "tex" },
--         },
--       },
--     })
--   end,
-- }


return {
  "nvim-treesitter/nvim-treesitter",
  -- build = ":TSUpdate",
  -- event = { "BufReadPre", "BufNewFile" },
  -- config = function()
  --   require("nvim-treesitter.configs").setup({
  --     highlight = { enable = true, additional_vim_regex_highlighting = false },
  --     indent = { enable = true },
  --     ensure_installed = { "lua", "python", "javascript" },
  --     disable = { "latex", "tex" },
  --     -- otras configuraciones
  --   })
  -- end,
}
