vim.opt_local.spell = true
vim.opt_local.spellcapcheck = ""
vim.opt_local.spelloptions:append("camel")
vim.cmd.compiler("node")

vim.keymap.set("n", "<leader>no", function()
  vim.cmd("botright terminal node")
  vim.cmd("wincmd J | startinsert")
end, { desc = "Open node repl in a termial split below" })
