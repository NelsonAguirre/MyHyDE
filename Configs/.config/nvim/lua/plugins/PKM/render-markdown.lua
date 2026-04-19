return {
  "MeanderingProgrammer/markdown.nvim",
  main = "render-markdown",
  name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" }, -- if you use standalone mini plugins
  -- dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
  file_types = { "markdown", "rmd", "qmd", "codecompanion" },
  opts = {
    render_modes = { "n", "c", "i" },
    heading = {
      -- Turn on / off heading icon & background rendering
      enabled = true,
      -- Turn on / off any sign column related rendering
      sign = true,
      -- Determines how the icon fills the available space:
      --  inline: underlying '#'s are concealed resulting in a left aligned icon
      --  overlay: result is left padded with spaces to hide any additional '#'
      position = "overlay",
      -- Replaces '#+' of 'atx_h._marker'
      -- The number of '#' in the heading determines the 'level'
      -- The 'level' is used to index into the array using a cycle
      --icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      icons = { "  ", "󰼐 ", "󰼑 ", "󰼒 ", "󰼓 ", "󰼔 " },
      --icons = { " ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      -- Added to the sign column if enabled
      -- The 'level' is used to index into the array using a cycle
      signs = { "󰫎 " },
      -- Width of the heading background:
      --  block: width of the heading text
      --  full: full width of the window
      width = "full",
      -- The 'level' is used to index into the array using a clamp
      -- Highlight for the heading icon and extends through the entire line
      backgrounds = {
        "RenderMarkdownH1Bg",
        "RenderMarkdownH2Bg",
        "RenderMarkdownH3Bg",
        "RenderMarkdownH4Bg",
        "RenderMarkdownH5Bg",
        "RenderMarkdownH6Bg",
      },
      -- The 'level' is used to index into the array using a clamp
      -- Highlight for the heading and sign icons
      foregrounds = {
        "RenderMarkdownH1",
        "RenderMarkdownH2",
        "RenderMarkdownH3",
        "RenderMarkdownH4",
        "RenderMarkdownH5",
        "RenderMarkdownH6",
      },
    },
    bullet = {
      -- Turn on / off list bullet rendering
      enabled = true,
      -- Replaces '-'|'+'|'*' of 'list_item'
      -- How deeply nested the list is determines the 'level'
      -- The 'level' is used to index into the array using a cycle
      -- If the item is a 'checkbox' a conceal is used to hide the bullet instead
      icons = { "◉", "○", "◆", "◇", "✿" },
      -- Padding to add to the right of bullet point
      right_pad = 1,
      -- Highlight for the bullet icon
      highlight = "RenderMarkdownBullet",
    },
    -- Checkboxes are a special instance of a 'list_item' that start with a 'shortcut_link'
    -- There are two special states for unchecked & checked defined in the markdown grammar
    -- Checkboxes are a special instance of a 'list_item' that start with a 'shortcut_link'
    -- There are two special states for unchecked & checked defined in the markdown grammar
    latex = {
      -- Whether LaTeX should be rendered, mainly used for health check
      -- Sirve para renderizar markdown, en una arriba
      enabled = false,
      -- Executable used to convert latex formula to rendered unicode
      converter = "latex2text",
      -- Highlight for LaTeX blocks
      highlight = "RenderMarkdownMath",
      -- Amount of empty lines above LaTeX blocks
      top_pad = 0,
      -- Amount of empty lines below LaTeX blocks
      bottom_pad = 0,
    },
    checkbox = {
      -- Turn on / off checkbox state rendering
      enabled = true,
      unchecked = {
        -- Replaces '[ ]' of 'task_list_marker_unchecked'
        icon = "󰄱 ",
        -- Highlight for the unchecked icon
        highlight = "RenderMarkdownUnchecked",
      },
      checked = {
        -- Replaces '[x]' of 'task_list_marker_checked'
        --icon = "󰱒 ",
        icon = "󰱒 ",
        -- Highligh for the checked icon
        highlight = "RenderMarkdownChecked",
      },
      -- Define custom checkbox states, more involved as they are not part of the markdown grammar
      -- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks
      -- Can specify as many additional states as you like following the 'todo' pattern below
      --   The key in this case 'todo' is for healthcheck and to allow users to change its values
      --   'raw': Matched against the raw text of a 'shortcut_link'
      --   'rendered': Replaces the 'raw' value when rendering
      --   'highlight': Highlight for the 'rendered' icon
      custom = {
        error = { raw = "[!]", rendered = "", hightlight = "RenderMarkdownError" },
        waiting = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
      },
    },
  },
}
