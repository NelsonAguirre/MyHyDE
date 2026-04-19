return {
  {
    -- for lsp features in code cells / embedded code
    "jmbuhr/otter.nvim",
    dev = false,
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
      },
    },
    opts = {
      verbose = {
        no_code_found = false,
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function()
      --local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      -- keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
      --disable a keymap
      --keys[#keys + 1] = { "[[", false }
      -- add a keymap
      --keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
      require("lspconfig").markdown_oxide.setup({
        filetypes = { "markdown", "rmd", "qmd", "md" },
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

      local lsp_flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
      }
      require("lspconfig").pyright.setup({
        capabilities = capabilities,
        flags = lsp_flags,
        mason = false,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
      })
    end,
  },
}
