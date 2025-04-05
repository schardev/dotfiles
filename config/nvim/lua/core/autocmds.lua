local autocmd = vim.api.nvim_create_autocmd
local map = require("core.utils").map

local my_local_group = vim.api.nvim_create_augroup("UserConfig", {})

autocmd("WinEnter", {
  group = my_local_group,
  pattern = "*",
  callback = function()
    if vim.fn.win_gettype() == "popup" then
      return
    end
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
    map("n", "q", ":q<CR>", { buffer = e.buf })
  end,
  desc = "Maps q to exit on non-filetypes",
})

autocmd("TextYankPost", {
  group = my_local_group,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 400 })
  end,
  desc = "Highlight text on yank (copy)",
})
