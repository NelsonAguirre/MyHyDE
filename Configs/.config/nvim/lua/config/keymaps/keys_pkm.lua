vim.api.nvim_set_keymap(
  "n",
  "<leader>Mc",
  ":MdMath clear<CR>",
  { noremap = true, silent = true, desc = "Reload MdMath" }
)

----- OBSIDIAN -----
vim.keymap.set(
  "n",
  "<leader>pc",
  "<cmd>lua require('obsidian').util.toggle_checkbox()<CR>",
  { desc = "Toggle Check Checkbox" }
)
vim.keymap.set("n", "<leader>pth", "<cmd>ObsidianTemplate<CR>", { desc = "Insert Obsidian Template Here" })
vim.keymap.set("n", "<leader>ptn", "<cmd>ObsidianNewFromTemplate<CR>", { desc = "Insert Template New Note" })
vim.keymap.set("n", "<leader>po", "<cmd>ObsidianOpen<CR>", { desc = "Open in Obsidian App" })
vim.keymap.set("n", "<leader>pb", "<cmd>ObsidianBacklinks<CR>", { desc = "Show Backlinks" })
vim.keymap.set("n", "<leader>pl", "<cmd>ObsidianLinks<CR>", { desc = "Show ObsidianLinks" })
vim.keymap.set("n", "<leader>pq", "<cmd>ObsidianQuickSwitch<CR>", { desc = "Quick Switch" })

--vim.keymap.set("n", "<leader>op", "<cmd>ObsidianPasteImg<CR>", { desc = "PasteImage" })

vim.keymap.set("n", "<leader>pnn", "<cmd>ObsidianNew<CR>", { desc = "Create New Note" })
vim.keymap.set("n", "<leader>pnt", "<cmd>ObsidianToday<CR>", { desc = "Open Today Note" })
vim.keymap.set("n", "<leader>pnr", "<cmd>ObsidianRename<CR>", { desc = "Rename in all obsidian" })
vim.keymap.set({ "v" }, "<leader>pne", "<cmd>ObsidianExtractNote<CR>", { desc = "Convert selection to a note" })
vim.keymap.set({ "n" }, "<leader>pk", "<cmd>ObsidianTOC<CR>", { desc = "Open TOC in Telescope" })

vim.keymap.set("n", "<leader>psw", "<cmd>ObsidianSearch<CR>", { desc = "Search Obsidian" })
vim.keymap.set("n", "<leader>pst", "<cmd>ObsidianTags<CR>", { desc = "Search tags" })

vim.keymap.set("n", "<leader>pgg", "<cmd>ObsidianBridgeOpenGraph<CR>", { desc = "Open graph view in Obsidian" })
vim.keymap.set("n", "<leader>pgt", "<cmd>ObsidianBridgeTelescopeCommand<CR>", { desc = "Open graph view in Obsidian" })

----- IMAGE -----

---paste image---
vim.keymap.set({ "n", "v", "i" }, "<leader>ip", function()
  local pasted_image = require("img-clip").paste_image()
  if pasted_image then
    vim.cmd("update") --Guarda el archivo, vim.cmd permite ejecutar comandos de vimscript
    print("Image pasted and file saved!")
    vim.cmd("stopinsert") --Sale del modo edición(si es que lo está) y entra en modo normal
    vim.cmd("stopinsert")
  else
    print("No image pasted. File not updated.")
  end
end, { desc = "Paste image from system clipboard" })

-- Open image under cursor in the program
vim.keymap.set("n", "<leader>io", function()
  local function get_image_path()
    local line = vim.api.nvim_get_current_line() --Obtiene la linea actual donde esta el cursor
    local image_pattern = { "%[.-%]%((.-)%)", "%[%[(.-)%]%]" } --patron que obtiene la imagen markdown
    -- Extract relative image path
    local path = function(pattern)
      local _, _, image_path = string.find(line, pattern) --Los "_" es para ignorar el resultado, lo que importa es el tercer valor que es el nombre de la imagen
      return image_path
    end
    return vim.tbl_map(path, image_pattern)
  end

  -- Get the image path
  local paths = get_image_path()
  local image_path
  for index, value in pairs(paths) do
    if value then
      image_path = value
      break
    end
  end

  if image_path then
    -- Check if the image path starts with "http" or "https"
    if string.sub(image_path, 1, 4) == "http" then
      print("URL image, use 'gx' to open it in the default browser.")
    else
      -- Construct absolute image path
      local current_file_path = vim.fn.expand("%:p:h") --- "%" da el nombre del archivo, ":p" expande la ruta y ":h" elimina el nombre del archivo de la ruta.
      local static_image_path

      --Entonces se encuentra dentro del voult de obsidian
      if not string.find(image_path, "/") and string.find(current_file_path, PKM_path) then -- DEl tipo ../imagen.png ../../img/figura.png dentro de obsidian
        static_image_path = PKM_path .. "/08-Attachments/" .. image_path
      else
        static_image_path = current_file_path .. "/" .. image_path
      end
      -- Abriendo la imagen
      local command = "xdg-open " .. vim.fn.shellescape(static_image_path) --el ultimo metodo es para escapar la ruta, pero se escapa con el objetivo de usarlo en la terminal!
      local _, result = pcall(function()
        return vim.fn.system(command)
      end)
      if not string.find(result, "does not exist") then
        print("Opened image in Preview: " .. static_image_path)
      else
        print("Failed to open image in Preview: " .. static_image_path)
      end
    end
  else
    print("No image found under the cursor")
  end
end, { desc = "Open image" })

-- Delete image under cursor
vim.keymap.set("n", "<leader>id", function()
  local function get_image_path()
    local line = vim.api.nvim_get_current_line() --Obtiene la linea actual donde esta el cursor
    local image_pattern = "%[.-%]%((.-)%)" --patron que obtiene la imagen markdown
    -- Extract relative image path
    local _, _, image_path = string.find(line, image_pattern) --Los "_" es para ignorar el resultado, lo que importa es el tercer valor que es el nombre de la imagen
    return image_path
  end

  -- Get the image path
  local image_path = get_image_path()

  if image_path then
    -- Check if the image path starts with "http" or "https"
    if string.sub(image_path, 1, 4) == "http" then
      vim.api.nvim_echo({
        { "URL image cannot be deleted from disk.", "WarningMsg" },
      }, false, {})
      print("URL image, use 'gx' to open it in the default browser.")
    else
      -- Construct absolute image path
      local current_file_path = vim.fn.expand("%:p:h") --- "%" da el nombre del archivo, ":p" expande la ruta y ":h" elimina el nombre del archivo de la ruta.
      local static_image_path
      if string.find(current_file_path, PKM_path) and not string.find(image_path, "/") then
        --Entonces se encuentra dentro del voult de obsidian
        static_image_path = PKM_path .. "/08-Attachments/" .. image_path
      else
        static_image_path = current_file_path .. "/" .. image_path
        print("static")
        print(static_image_path)
      end
      -- Prompt for confirmation before deleting the image
      vim.ui.input({ prompt = "Delete image file? (y/n)" }, function(input)
        if input == "y" or input == "Y" then
          local success, _ = pcall(function()
            local command = "rm " .. vim.fn.shellescape(static_image_path)
            return vim.fn.system(command)
          end)
          if success then
            vim.api.nvim_echo({
              { "Image file deleted from disk:\n", "Normal" },
              { static_image_path, "Normal" },
            }, false, {})
          else
            vim.api.nvim_echo({
              { "Failed to delete image file:\n", "ErrorMsg" },
              { static_image_path, "ErrorMsg" },
            }, false, {})
          end
        else
          vim.api.nvim_echo({
            { "Image deletion canceled.", "Normal" },
          }, false, {})
        end
      end)
    end
  else
    vim.api.nvim_echo({
      { "No image found under the cursor", "WarningMsg" },
    }, false, {})
  end
end, { desc = "Delete image" })
