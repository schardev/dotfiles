local autocmd = vim.api.nvim_create_autocmd
local fn = vim.fn

-- Whitespace highlighting
-- Taken from https://github.com/akinsho/dotfiles

-- Do not highlight whitespaces in below filetypes
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
