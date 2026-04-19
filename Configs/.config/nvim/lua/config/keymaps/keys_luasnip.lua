local ls = require("luasnip")

vim.keymap.set({ "i", "s" }, "<C-ñ>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "đ", function()
  if ls.jumpable(1) then
    ls.jump(1)
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "ð", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })
