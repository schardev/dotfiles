local autocmd = vim.api.nvim_create_autocmd
local map = require("core.utils").map

local user_core_augroup = vim.api.nvim_create_augroup("user.core", {})

autocmd("WinEnter", {
  group = user_core_augroup,
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
  group = user_core_augroup,
  pattern = "*",
  callback = function()
    vim.wo.cursorline = false
    vim.wo.colorcolumn = ""
  end,
  desc = "Remove cursorline and colorcolumn from inactive window",
})

autocmd("FileType", {
  group = user_core_augroup,
  pattern = {
    "checkhealth",
    "gitsigns-blame",
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
    map("n", "q", function()
      vim.cmd("close")
      pcall(vim.api.nvim_buf_delete, e.buf, { force = true })
    end, { buf = e.buf })
  end,
  desc = "Maps q to exit on non-filetypes",
})

autocmd("TextYankPost", {
  group = user_core_augroup,
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 400 })
  end,
  desc = "Highlight text on yank (copy)",
})

-- Whitespace highlighting
local fn = vim.fn

local ignore_filetypes = {
  "c",
  "kconfig",
  "make",
}

local function is_floating_win()
  return fn.win_gettype() == "popup"
end

local function is_invalid_buf()
  return vim.bo.filetype == "" or vim.bo.buftype ~= "" or not vim.bo.modifiable
end

local function is_ignored()
  return vim.tbl_contains(ignore_filetypes, vim.bo.filetype)
end

local function highlight_trailing()
  if is_invalid_buf() or is_floating_win() or is_ignored() then
    return
  end

  local space_pattern = [[\s\+$]]
  if vim.w.space_match_number then
    fn.matchdelete(vim.w.space_match_number)
    fn.matchadd("ExtraWhitespace", space_pattern, 10, vim.w.space_match_number)
  else
    vim.w.space_match_number = fn.matchadd("ExtraWhitespace", space_pattern)
  end

  local tabs_pattern = [[\t]]
  if vim.w.tabs_match_number then
    fn.matchdelete(vim.w.tabs_match_number)
    fn.matchadd("Tabs", tabs_pattern, 11, vim.w.tabs_match_number)
  else
    vim.w.tabs_match_number = fn.matchadd("Tabs", tabs_pattern)
  end
end

autocmd({ "BufEnter", "FileType", "InsertLeave" }, {
  pattern = "*",
  callback = highlight_trailing,
  desc = "Highlight trailing whitespace",
})
