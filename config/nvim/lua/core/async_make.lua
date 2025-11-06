local M = {}

---@type string|nil
local process_cwd = nil

function M.make()
  local makeprg = vim.bo.makeprg
  if not makeprg then
    return
  end

  local lines = { "" }
  local cmd = vim.fn.expandcmd(vim.bo.makeprg)
  local errorformat = vim.bo.errorformat

  ---@param err string|nil
  ---@param data string|nil
  local function on_event(err, data)
    if data then
      vim.list_extend(lines, { data })
    end
  end

  ---@param out vim.SystemCompleted
  local function on_exit(out)
    process_cwd = nil

    if out.code == 0 then
      vim.notify("[MAKE]: Compilation successful!", vim.log.levels.INFO)
    else
      vim.notify("[MAKE]: Compilation failed!", vim.log.levels.ERROR)
      vim.fn.setqflist({}, " ", {
        title = cmd,
        lines = lines,
        efm = errorformat,
      })
      vim.api.nvim_command("doautocmd QuickFixCmdPost")
    end
  end

  local current_directory = vim.fn.getcwd()

  if process_cwd == current_directory then
    vim.notify(
      "Compilation already in process at " .. process_cwd,
      vim.log.levels.WARN
    )
  else
    process_cwd = current_directory

    vim.system(
      vim.split(cmd, " "),
      { stdout = on_event, stderr = on_event },
      vim.schedule_wrap(on_exit)
    )
  end
end

return M
