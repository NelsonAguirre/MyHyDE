return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "Principal",
        path = PKM_path,
      },
    },
    completion = {
      nvim_cmp = false,
      min_chars = 2,
    },
    new_notes_location = "notes_subdir",
    notes_subdir = "01-Inbox", -- Subdirectorio donde se guardarán las notas

    daily_notes = { --Diario
      folder = "02-Diario",
      date_format = "%d-%m-%Y", --Esto es para configurar el ID
      template = "tp.daily-nvim.md",
    },
    -- attachments
    attachments = {
      img_folder = "06-Attachments",

      img_text_func = function(client, path)
        path = client:vault_relative_path(path) or path
        return string.format("![%s](%s)", path.name:match("([^/\\]+)%.([^%.]+)$"), path.name)
      end,
    },
    image_name_func = function()
      return string.format("%s", os.time()) --retorna el tiempo, que será el nombre de la imagen.
    end,
    -- Either 'wiki' or 'markdown'.
    preferred_link_style = "wiki",
    -- Optional, boolean or a function that takes a filename and returns a boolean.
    -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
    disable_frontmatter = true,

    note_frontmatter_func = function(note) --Se refiere a las propiedades de un archivo de markdownCode. -Esto es válido al crear una nota con ObsidianNew.
      -- This is equivalent to the default frontmatter function.
      local out = {}
      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then --"vim.tbl_isempty"-> Verifica si la tabla está vacía
        for k, v in pairs(note.metadata) do
          out[k] = v --Agrega los metadatos(frontmatter) a "out"
        end
      end
      return out
    end,

    mappings = {
      --Obsidian follow
      ["<leader>pf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true, desc = "Open the link" },
      },
      --Toggle check-boxes "obsidian done"
      -- ["<leader>pd"] = {
      --   action = function()
      --     return require("obsidian").util.toggle_checkbox()
      --   end,
      --   opts = { buffer = true, desc = "Toogle Check-boxes" },
      -- },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ["<leader>pa"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },
    note_id_func = function(title) --Id que sale al principio de las notas
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        --suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower() --Por defecto
        suffix = title
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return suffix
      --return tostring(os.time()) .. "-" .. suffix
    end,

    templates = {
      folder = "99-Meta/Templates/Template",
      date_format = "%d-%m-%Y",
      time_format = "%H:%M",
      substitutions = { --Crear variables para los templates haciendo uso de Lua
        yesterday = function()
          return os.date("%d-%m-%Y", os.time() - 86400)
        end,
        tomorrow = function()
          return os.date("%d-%m-%Y", os.time() + 86400)
        end,
        day_of_week = function()
          local day_of_week = os.date("%A") --La función os.date("%A") obtiene directamente el nombre del día de la semana sin necesidad de crear una tabla de fecha intermedia.
          return day_of_week
        end,
      },
    },
    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    ---@param url string
    follow_url_func = function(url)
      -- Open the URL in the default web browser.
      vim.fn.jobstart({ "xdg-open", url }) -- linux
    end,

    -- Optional, set to true if you use the Obsidian Advanced URI plugin.
    -- https://github.com/Vinzent03/obsidian-advanced-uri
    use_advanced_uri = true,
    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
      name = "telescope.nvim",
      -- Optional, configure key mappings for the picker. These are the defaults.
      -- Not all pickers support all mappings.
      mappings = {
        -- Create a new note from your query.
        new = "<C-x>",
        -- Insert a link to the selected note.
        insert_link = "<C-l>",
      },
    },
    -- Optional, sort search results by "path", "modified", "accessed", or "created".
    -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
    -- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
    sort_by = "modified",
    sort_reversed = true,
    search_max_lines = 1000,
    -- Optional, determines how certain commands open notes. The valid options are:
    -- 1. "current" (the default) - to always open in the current window
    -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
    -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
    open_notes_in = "current", -- funciona al crear una nota segun un template
    ui = {
      enable = false, -- set to false to disable all additional syntax features
    },
  },

  -- Optional, configure additional syntax highlighting / extmarks.
  -- This requires you have `conceallevel` set to 1 or 2. See `:help conceallevel` for more details.
  -- Al parecer tampoco funciona :(
}
