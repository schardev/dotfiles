local autocmd = vim.api.nvim_create_autocmd
local nnoremap = require("core.utils").mapper_factory("n")

local my_local_group = vim.api.nvim_create_augroup("MyLocalGroup", {})

autocmd("WinEnter", {
  group = my_local_group,
  pattern = "*",
  callback = function()
    vim.wo.cursorline = true
    vim.wo.colorcolumn = "80"
  end,
  desc = "Highlight cursorline and colorcolumn on active window",
})

autocmd("WinLeave", {
  group = my_local_group,
  pattern = "*",
  callback = function()
    vim.wo.cursorline = false
    vim.wo.colorcolumn = ""
  end,
  desc = "Remove cursorline and colorcolumn from inactive window",
})

autocmd("TermOpen", {
  group = my_local_group,
  pattern = "*",
  callback = function()
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.signcolumn = "no"
  end,
  desc = "Disable line numbers in terminal window",
})

autocmd("BufEnter", {
  group = my_local_group,
  pattern = "*",
  callback = function(params)
    -- Map q to exit in non-filetype/non-listed buffer
    if vim.bo.buftype == "nofile" or not vim.bo.buflisted then
      nnoremap("q", ":q<CR>", { buffer = params.buf })
    end
  end,
  desc = "Maps q to exit on non-filetypes",
})

autocmd("FileType", {
  group = my_local_group,
  pattern = { "lspinfo", "null-ls-info" },
  callback = function()
    -- Add border to `:LspInfo` and `:NullLsInfo` commands
    -- https://github.com/neovim/nvim-lspconfig/issues/1717
    vim.api.nvim_win_set_config(0, { border = "rounded" })
  end,
  desc = "Set borders to few floating windows",
})

autocmd("TextYankPost", {
  group = my_local_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 400 })
  end,
  desc = "Highlight text on yank (copy)",
})

autocmd("FileType", {
  group = my_local_group,
  pattern = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
  callback = function()
    vim.opt_local.spell = true

    -- When a word is CamelCased, assume "Cased" is a separate word
    vim.opt_local.spelloptions:append("camel")
  end,
  desc = "ECMA specific file settings",
})
