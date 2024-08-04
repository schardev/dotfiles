local autocmd = vim.api.nvim_create_autocmd
local nnoremap = require("core.utils").mapper_factory("n")

local my_local_group = vim.api.nvim_create_augroup("UserConfig", {})

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

autocmd("FileType", {
  group = my_local_group,
  pattern = {
    "checkhealth",
    "help",
    "lspinfo",
    "qf",
    "query",
    "startuptime",
    "tsplayground",
  },
  callback = function(e)
    -- Map q to exit in non-filetype buffers
    vim.bo[e.buf].buflisted = false
    nnoremap("q", ":q<CR>", { buffer = e.buf })
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
