-- Source javascript ftplugin
vim.cmd("runtime! ftplugin/javascript.lua")

---@type string|nil
local tsc_process_cwd = nil

--- Gets the current node package manager
local function get_package_manager()
  local git_root = vim.fs.root(0, ".git")

  if vim.uv.fs_stat(vim.fs.joinpath(git_root, "package-lock.json")) then
    return "npm"
  elseif vim.uv.fs_stat(vim.fs.joinpath(git_root, "yarn.lock")) then
    return "yarn"
  else
    return "pnpm"
  end
end

---@param output string
local function get_qf_from_errors(output)
  local quickfix_entries = {}
  local lines = vim.split(output, "\n", { trimempty = true })

  for _, line in ipairs(lines) do
    local filename, lnum, col, msg =
      string.match(line, "(.+)%((%d+),(%d+)%):%s*error%s*(.*)")
    if filename then
      table.insert(quickfix_entries, {
        filename = filename,
        lnum = tonumber(lnum),
        col = tonumber(col),
        text = msg,
        type = "E",
      })
    end
  end

  return quickfix_entries
end

---@param out vim.SystemCompleted
local function on_exit(out)
  tsc_process_cwd = nil

  if out.code == 0 then
    vim.notify("TypeScript compilation successful!")
  else
    vim.notify("TypeScript compilation failed!")
    local quickfix_entries = get_qf_from_errors(out.stdout)
    if #quickfix_entries > 0 then
      vim.schedule(function()
        vim.fn.setqflist(quickfix_entries)
        -- vim.cmd("copen") -- Open the quickfix list
      end)
    end
  end
end

local function compile()
  local pkg_manager = get_package_manager()
  local current_directory = vim.fn.getcwd()
  if tsc_process_cwd == current_directory then
    vim.print("TS compilation already in process at " .. tsc_process_cwd)
  else
    tsc_process_cwd = current_directory
    vim.system(
      { pkg_manager, "tsc", "--noEmit" },
      { text = true },
      vim.schedule_wrap(on_exit)
    )
  end
end

vim.keymap.set(
  "n",
  "<F5>",
  compile,
  { buffer = true, desc = "Compile using TS" }
)

-- Surround
local installed, surround = pcall(require, "nvim-surround")

if not installed then
  return
end

local config = require("nvim-surround.config")

surround.buffer_setup({
  surrounds = {
    -- https://github.com/kylechui/nvim-surround/discussions/53
    ["g"] = {
      add = function()
        local result = config.get_input("Enter the generic name: ")
        if result then
          return { { result .. "<" }, { ">" } }
        end
      end,
      find = function()
        return config.get_selection({ node = "generic_type" })
      end,
      delete = "^(.-<)().-(>)()$",
      change = {
        target = "^(.-<)().-(>)()$",
        replacement = function()
          local result = config.get_input("Enter the generic name: ")
          if result then
            return { { result .. "<" }, { ">" } }
          end
        end,
      },
    },
  },
})
