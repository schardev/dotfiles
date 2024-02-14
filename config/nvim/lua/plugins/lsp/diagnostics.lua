local M = {}
local icons = require("core.icons").diagnostics

-- Diagnostic signs and highlight group
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

---@param diagnostic lsp.Diagnostic
local diagnostics_prefix = function(diagnostic)
  local severity = diagnostics_signs[diagnostic.severity]
  return severity.sign, severity.hl_groupl
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
    float = {
      max_width = 85,
      max_height = 30,
      border = "rounded",
      prefix = diagnostics_prefix,
      scope = "line",
      source = "always",
    },
    underline = {
      -- Do not underline text when severity is low (INFO or HINT).
      severity = { min = vim.diagnostic.severity.WARN },
    },
  })
end

return M
