-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-----  Oil -----
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-----  PKM  -----
require("config.keymaps.keys_pkm")

----- VIMTEX ------

require("config.keymaps.keys_vimtex")

----- LUASNIP -----

require("config.keymaps.keys_luasnip")

----- VARIOS ------
vim.api.nvim_set_keymap("i", "<c-r>", "<c-g>u<Esc>[s1z=`^a<c-g>u", { noremap = true, silent = true })
