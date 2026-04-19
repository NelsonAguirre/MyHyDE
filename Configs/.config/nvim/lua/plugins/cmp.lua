return {
  "hrsh7th/nvim-cmp",
  event = "insertEnter",
  dependencies = {
    -- "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
    "onsails/lspkind.nvim", -- vs-code like pictograms
    "L3MON4D3/LuaSnip",
    -- "saadparwaiz1/cmp_luasnip", -- for autocompletion
    "jmbuhr/otter.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-emoji",
    "jmbuhr/cmp-pandoc-references",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    cmp.setup({
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = "menu,menuone,preview,noinsert",
      },
      mapping = cmp.mapping.preset.insert({
        --["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
        --["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<C-e>"] = cmp.mapping.abort(), -- close completion window
        ["<C-ñ>"] = cmp.mapping.confirm({ select = true }),
      }),
      autocomplete = false, --Si es false, se debe precionar C-Space para que recien muestre las sugerencias.

      -- Formato
      ---@diagnostic disable-next-line: missing-fields
      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol",
          menu = {
            otter = "[🦦]",
            pandoc_references = "[Ref]",
            nvim_lsp = "[LSP]",
            nvim_lsp_signature_help = "[sig]",
            -- luasnip = "[snip]",
            -- buffer = "[buf]",
            path = "[path]",
            -- spell = "[spell]",
            -- tags = "[tag]",
            treesitter = "[TS]",
            emoji = "[emoji]",
          },
        }),
      },
      sources = cmp.config.sources({
        { name = "pandoc_references" },
        {
          name = "luasnip",
          option = { keyword_length = 3, max_item_count = 3, use_show_condition = false, show_autosnippets = false },
        },
        { name = "nvim_lsp" },
        { name = "path" }, -- file system paths
        { name = "otter" },
        -- { name = "buffer", keyword_length = 5, max_item_count = 3 }, -- text within current buffer
        { name = "emoji" },
        { name= "codecompanion"}
      }),
      view = {
        entries = "native",
      },
      luasnip.filetype_extend("quarto", { "markdown" }),
      luasnip.filetype_extend("rmarkdown", { "markdown" }),
    })
  end,
}
