local M = {}

--- Returns LSP servers list to enable
M.get_lsp_servers = function()
  local env = require("core.env")

  --- Server names are according to lspconfig (see `:h lspconfig-all`)
  local servers = {
    "cssls",
    -- "cssmodules_ls",
    "dockerls",
    "emmet_language_server",
    "eslint",
    "html",
    "jsonls",
    "lua_ls",
    "tailwindcss",
    "yamlls",
    "taplo",
  }

  if env.NVIM_USER_USE_TS_LS then
    table.insert(servers, "ts_ls")
  else
    table.insert(servers, "vtsls")
  end

  return servers
end

M.formatters = {
  -- "eslint_d",
  "prettierd",
}

return M
