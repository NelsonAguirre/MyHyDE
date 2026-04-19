local function delete_file(input)
  local file_path = vim.fn.expand("%:p")
  if input == "y" or input == "Y" then
    local success, _ = pcall(function()
      local command = "rm " .. vim.fn.shellescape(file_path)
      return vim.fn.system(command)
    end)
    if success then
      vim.api.nvim_echo({
        { "File deleted from disk:\n", "Normal" },
        { file_path, "Normal" },
      }, false, {})
      vim.cmd("bd!")
    else
      vim.api.nvim_echo({
        { "Failed to delete file:\n", "ErrorMsg" },
        { file_path, "ErrorMsg" },
      }, false, {})
    end
  else
    vim.api.nvim_echo({
      { "File deletion canceled.", "Normal" },
    }, false, {})
  end
end

vim.keymap.set("n", "<leader>fd", function()
  vim.ui.input({ prompt = "Delete the current file? (y/n)" }, function(input)
    delete_file(input)
  end)
end, { desc = "Delete current file" })

-- Copy file path / filepath to the clipboard
vim.keymap.set("n", "<leader>fp", function()
  local filePath = vim.fn.expand("%:~") -- Gets the file path relative to the home directory
  vim.fn.setreg("+", filePath) -- Define un registro. "+" representa el registro del portapapeles y el otro parámetro es lo que va a estar en dicho registro.
  print("File path copied to clipboard: " .. filePath) -- Optional: print message to confirm
end, { desc = "Copy file path to clipboard" })
