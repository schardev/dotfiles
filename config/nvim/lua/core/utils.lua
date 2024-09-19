local M = {}

--- Save the current buffer and execute the file
function M.save_and_exec()
  if vim.bo.filetype == "vim" then
    vim.cmd([[
        silent! write
        source %
        ]])
  elseif vim.bo.filetype == "lua" then
    vim.cmd([[
        silent! write
        luafile %
        ]])
  end
end

--- Creates a keymap function with given mode
---@param mode string|table
---@return fun(lhs: string, rhs: string|function, opts?: vim.keymap.set.Opts)
function M.mapper_factory(mode)
  local default_opts = { silent = true }

  return function(lhs, rhs, opts)
    local final_opts = vim.tbl_extend("force", default_opts, opts or {})
    vim.keymap.set(mode, lhs, rhs, final_opts)
  end
end

--- Navigate to the given direction if there exists a window in that direction
--- else redirects the direction to `wezterm` to change the active pane
---@param direction string
function M.navigate_pane_or_window(direction)
  local current_winnr = vim.fn.winnr()
  local wezterm_direction = { h = "Left", j = "Down", k = "Up", l = "Right" }
  if current_winnr ~= vim.fn.winnr(direction) then
    vim.cmd("wincmd " .. direction)
  else
    vim.system({
      "wezterm",
      "cli",
      "activate-pane-direction",
      wezterm_direction[direction],
    })
  end
end

--- Open the current file/word under cursor in vim if it exists else open it via xdg_open
function M.open()
  local file = vim.fn.expand("<cfile>")
  if file:match("https?://") then
    return vim.ui.open(file)
  end

  if vim.fn.filereadable(vim.fn.expand(file)) > 0 then
    return vim.cmd("edit " .. file)
  end

  -- consider anything that looks like string/string a github link
  local plugin_url_regex = "[%a%d%-%.%_]*%/[%a%d%-%.%_]*"
  local link = string.match(file, plugin_url_regex)
  if link then
    return vim.ui.open(string.format("https://www.github.com/%s", link))
  end

  -- fallback to system open
  local _, err = vim.ui.open(file)
  if err then
    vim.notify(err, vim.log.levels.ERROR)
  end
end

--- Get language from the current cursor position
function M.get_lang_from_cursor_pos()
  local has_parser, parser = pcall(vim.treesitter.get_parser)

  -- If no parser is found then just return the current filetype instead of failing
  if not has_parser then
    return vim.bo.filetype
  end

  local cursor = vim.api.nvim_win_get_cursor(0)
  cursor[1] = cursor[1] - 1 -- treesitter nodes are 0-indexed

  return parser
    :language_for_range({
      cursor[1],
      cursor[2],
      cursor[1],
      cursor[2],
    })
    :lang()
end

--- Common string utilities
---@see https://github.com/tbastos/lift/blob/master/lift/string.lua

--- Returns a capitilzed string
---@param str string
local function capitalize(str)
  return str:gsub("^%l", string.upper)
end

--- Converts a string to camelCase
---@param str string
local function to_camel_case(str)
  return str:gsub("%W+(%w+)", capitalize)
end

--- Converts a string to PascalCase
---@param str string
local function to_pascal_case(str)
  return str:gsub("%W*(%w+)", capitalize)
end

local function basename(str)
  return str:gsub("(.*)/(.*)", "%2")
end

M.string_utils = {
  capitalize = capitalize,
  to_camel_case = to_camel_case,
  to_pascal_case = to_pascal_case,
  basename = basename,
}

return M
