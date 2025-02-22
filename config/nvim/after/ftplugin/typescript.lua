-- Source javascript ftplugin
vim.cmd("runtime! ftplugin/javascript.lua")

local function compile()
  local pkg_manager = "pnpm"
  local git_root = vim.fs.root(0, ".git")

  if vim.uv.fs_stat(vim.fs.joinpath(git_root, "package-lock.json")) then
    pkg_manager = "npm"
  elseif vim.uv.fs_stat(vim.fs.joinpath(git_root, "yarn.lock")) then
    pkg_manager = "yarn"
  end

  ---@param out vim.SystemCompleted
  local function on_exit(out)
    if out.code == 0 then
      vim.notify("TypeScript compilation successful!")
    else
      vim.notify("TypeScript compilation failed!")

      local quickfix_entries = {}
      local lines = vim.split(out.stdout, "\n", { trimempty = true })

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

      if #quickfix_entries > 0 then
        vim.schedule(function()
          vim.fn.setqflist(quickfix_entries)
          -- vim.cmd("copen") -- Open the quickfix list
        end)
      end
    end
  end

  vim.system(
    { pkg_manager, "tsc", "--noEmit" },
    { text = true },
    vim.schedule_wrap(on_exit)
  )
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
