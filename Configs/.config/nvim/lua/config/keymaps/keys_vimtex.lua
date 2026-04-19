vim.api.nvim_set_keymap(
  "n",
  "[z",
  "<plug>(vimtex-[[)",
  { noremap = false, silent = true, desc = "VimTex-Prev. Section" }
)
vim.api.nvim_set_keymap(
  "n",
  "]z",
  "<plug>(vimtex-]])",
  { noremap = false, silent = true, desc = "VimTex-Next Section" }
)
vim.api.nvim_set_keymap(
  "n",
  "[v",
  "<plug>(vimtex-[m)",
  { noremap = false, silent = true, desc = "VimTex-Prev. Start Environment" }
)
vim.api.nvim_set_keymap(
  "n",
  "]v",
  "<plug>(vimtex-]m)",
  { noremap = false, silent = true, desc = "VimTex-Next. Start Environment" }
)

vim.api.nvim_set_keymap(
  "n",
  "[V",
  "<plug>(vimtex-[M)",
  { noremap = false, silent = true, desc = "VimTex-Prev. End Environment" }
)
vim.api.nvim_set_keymap(
  "n",
  "]V",
  "<plug>(vimtex-]M)",
  { noremap = false, silent = true, desc = "VimTex-Next. End Environment" }
)
-- Delete surrounding
vim.api.nvim_set_keymap(
  "n",
  "gsdc",
  "<plug>(vimtex-cmd-delete)",
  { noremap = true, silent = true, desc = "VimTex-Cmd Delete" }
)

vim.api.nvim_set_keymap(
  "n",
  "gsde",
  "<plug>(vimtex-env-delete)",
  { noremap = true, silent = true, desc = "VimTex-Env. Delete" }
)
vim.api.nvim_set_keymap(
  "n",
  "gsd$",
  "<plug>(vimtex-env-delete-math)",
  { noremap = true, silent = true, desc = "VimTex-Math Delete" }
)
vim.api.nvim_set_keymap(
  "n",
  "gsdd",
  "<plug>(vimtex-delim-delete)",
  { noremap = true, silent = true, desc = "VimTex-Delim Delete" }
)
-- Change surrounding
vim.api.nvim_set_keymap(
  "n",
  "gsrc",
  "<plug>(vimtex-cmd-change)",
  { noremap = true, silent = true, desc = "VimTex-Cmd Replace" }
)

vim.api.nvim_set_keymap(
  "n",
  "gsre",
  "<plug>(vimtex-env-change)",
  { noremap = true, silent = true, desc = "VimTex-Env. Change" }
)
vim.api.nvim_set_keymap(
  "n",
  "gsr$",
  "<plug>(vimtex-env-change-math)",
  { noremap = true, silent = true, desc = "VimTex-Math Change" }
)
vim.api.nvim_set_keymap(
  "n",
  "gsrd",
  "<plug>(vimtex-delim-change-math)",
  { noremap = true, silent = true, desc = "VimTex-Delim Change" }
)
-- Toggle surrounding
vim.api.nvim_set_keymap(
  "n",
  "gstc",
  "<plug>(vimtex-cmd-toggle-star)",
  { noremap = true, silent = true, desc = "VimTex-Cmd Toggle Star" }
)

vim.api.nvim_set_keymap(
  "n",
  "gste",
  "<plug>(vimtex-env-toggle-star)",
  { noremap = true, silent = true, desc = "VimTex-Env. Toggle Star" }
)
vim.api.nvim_set_keymap(
  "n",
  "gst$",
  "<plug>(vimtex-env-toggle-math)",
  { noremap = true, silent = true, desc = "VimTex-Math Toggle" }
)
vim.api.nvim_set_keymap(
  "n",
  "gstd",
  "<plug>(vimtex-delim-toggle-modifier)",
  { noremap = true, silent = true, desc = "VimTex-Delimiter Toogle" }
)
vim.api.nvim_set_keymap(
  "n",
  "gstD",
  "<plug>(vimtex-delim-toggle-modifier-reverse)",
  { noremap = true, silent = true, desc = "VimTex-Delimiter Toogle Reverse" }
)
