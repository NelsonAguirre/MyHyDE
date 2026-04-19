return {
  "lervag/vimtex",
  lazy = false, -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_delim_toggle_mod_list = {
      { "\\big", "\\big" },
      { "\\left", "\\right" },
    } -- Modifico la lista de toogle de los limitadores (mi shortcut: gstd)
    vim.g.vimtex_imaps_enabled = 0
  end,
}
