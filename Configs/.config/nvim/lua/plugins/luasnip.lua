return {
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
  -- install jsregexp (optional!).
  build = "make install_jsregexp",
  dependencies = {},
  opts = {
    enable_autosnippets = true, --enable autotriggered(expansión automática) snippet
    update_events = "TextChanged,TextChangedI",
    store_selection_keys = "<Tab>", --Almacenar texto en modo edición.
  },
}
