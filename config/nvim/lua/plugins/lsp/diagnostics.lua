local M = {}
local icons = require("core.icons").diagnostics

-- Set diagnostic signs and highlight group
local diagnostics_signs = {
  [vim.diagnostic.severity.ERROR] = {
    sign = string.format("%s ", icons.error),
    hl_group = "DiagnosticSignError",
  },
  [vim.diagnostic.severity.WARN] = {
    sign = string.format("%s ", icons.warning),
    hl_group = "DiagnosticSignWarn",
  },
  [vim.diagnostic.severity.HINT] = {
    sign = string.format("%s ", icons.hint),
    hl_group = "DiagnosticSignHint",
  },
  [vim.diagnostic.severity.INFO] = {
    sign = string.format("%s ", icons.info),
    hl_group = "DiagnosticSignInfo",
  },
}

-- Diagnostic float options (for vim.diagnostic.open_float)
local diagnostics_float_config = {
  border = "rounded",
  prefix = function(diagnostic)
    local severity = diagnostics_signs[diagnostic.severity]
    return severity.sign, severity.hl_group
  end,
  scope = "line",
  source = "always",
}

-- Show the popup diagnostics window, but only once for the current cursor location
-- by checking whether the word under the cursor has changed.
-- (Thanks @akinsho)
function M.diagnostics_float_handler()
  -- Immediately return if the screen width can show virtual text
  -- Mostly done for window splits and termux
  if vim.fn.winwidth(0) > 100 then
    return
  end

  -- Don't open floating window if there's already one opened
  for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
    if vim.api.nvim_win_get_config(winid).zindex then
      return
    end
  end

  local cword = vim.fn.expand("<cword>")
  if cword ~= vim.w.lsp_diagnostics_cword then
    vim.w.lsp_diagnostics_cword = cword
    vim.diagnostic.open_float(diagnostics_float_config)
  end
end

function M.setup()
  for _, severity in pairs(diagnostics_signs) do
    vim.fn.sign_define(severity.hl_group, {
      text = severity.sign,
      texthl = severity.hl_group,
      numhl = severity.hl_group,
    })
  end

  -- Global diagnostic config
  vim.diagnostic.config({
    virtual_text = function()
      -- Disable virtual text on smaller screens
      return vim.fn.winwidth(0) > 100
    end,
    float = diagnostics_float_config,
    underline = {
      -- Do not underline text when severity is low (INFO or HINT).
      severity = { min = vim.diagnostic.severity.WARN },
    },
  })
end

return M
