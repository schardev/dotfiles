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
  return severity.sign, severity.hl_group
end

function M.setup()
  local signs = { text = {} }
  for severity, config in pairs(diagnostics_signs) do
    signs.text[severity] = config.sign
  end

  -- Global diagnostic config
  vim.diagnostic.config({
    signs = signs,
    virtual_text = { prefix = diagnostics_prefix },
    float = {
      max_width = 85,
      max_height = 30,
      border = "rounded",
      prefix = diagnostics_prefix,
      scope = "line",
      source = true,
    },
    underline = {
      -- Do not underline text when severity is low (INFO or HINT).
      severity = { min = vim.diagnostic.severity.WARN },
    },
  })
end

return M
