-- https://github.com/b0o/nvim-conf/blob/dad348a6988266c648d59891caee8debc0550d59/lua/user/mappings.lua#L393
local function is_loclist(winid)
  return vim.fn.win_gettype(winid) == "loclist"
end

local function get_list(winid)
  return is_loclist(winid) and vim.fn.getloclist(winid) or vim.fn.getqflist()
end

local function set_list(winid, list, action)
  if is_loclist(winid) then
    vim.fn.setloclist(winid, list, action)
  else
    vim.fn.setqflist(list, action)
  end
end

vim.keymap.set("n", "dd", function()
  local winid = vim.api.nvim_get_current_win()
  local line = vim.fn.line(".")
  set_list(
    winid,
    vim.fn.filter(get_list(winid), function(idx)
      return idx ~= line - 1
    end),
    "r"
  )
  vim.fn.setpos(".", { 0, line, 1, 0 })
end, { desc = "Delete item from quickfix list", buffer = true })

vim.keymap.set("v", "d", function()
  vim.schedule(function()
    local winid = vim.api.nvim_get_current_win()
    local start = vim.fn.line("'<")
    local finish = vim.fn.line("'>")
    set_list(
      winid,
      vim.fn.filter(get_list(winid), function(idx)
        return idx < start - 1 or idx >= finish
      end),
      "r"
    )
    vim.fn.setpos(".", { 0, start, 1, 0 })
  end)
  vim.cmd([[call feedkeys("\<Esc>", 'n')]])
end, { desc = "Delete item from quickfix list", buffer = true })

vim.cmd.packadd("cfilter")
