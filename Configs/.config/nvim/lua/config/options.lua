-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.spell = true
vim.opt.spelllang = "es,en"
-- vim.opt.spellfile = {
--   os.getenv("HOME") .. "/.config/nvim/spell/es.utf-8.add",
--   os.getenv("HOME") .. "/.config/nvim/spell/en.utf-8.add",
-- }
vim.opt.spellfile = os.getenv("HOME") .. "/.config/nvim/spell/es.utf-8.add" -- solo uno personalizado

vim.g.lazyvim_prettier_needs_config = false
vim.opt.conceallevel = 1
vim.g.lazyvim_cmp = "nvim-cmp"
