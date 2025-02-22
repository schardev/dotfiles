vim.opt_local.spell = true
vim.opt_local.spelloptions:append("camel")
vim.opt_local.spellcapcheck = ""

vim.keymap.set("n", "<Leader>no", function()
  vim.cmd("botright terminal node")
  vim.cmd("wincmd J | startinsert")
end, { desc = "Open node repl in a termial split below" })
