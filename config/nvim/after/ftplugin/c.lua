-- Hax to prevent c.vim from clearing tabs highlighting for cpp.vim, since vim
-- sources c.vim for cpp files as well (see /usr/share/[n]vim/runtime/ftplugin/c.vim)
if vim.bo.filetype ~= "c" then
  return
end

-- Set indentation to match linux-kernel coding style
vim.bo.expandtab = false
vim.bo.shiftwidth = 8
vim.bo.softtabstop = 8
vim.bo.tabstop = 8

vim.opt_local.spell = true
