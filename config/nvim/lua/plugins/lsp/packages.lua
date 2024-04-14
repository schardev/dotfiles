local env = require("core.env")
local M = {}
local NIL = {}

-- Server names are according to lspconfig (see `:h lspconfig-all`)
M.servers = {
  cssls = NIL,
  -- cssmodules_ls = NIL,
  dockerls = NIL,
  emmet_ls = require("plugins.lsp.servers.emmet_ls"),
  eslint = NIL,
  html = NIL,
  jsonls = require("plugins.lsp.servers.jsonls"),
  lua_ls = require("plugins.lsp.servers.lua_ls"),
  tailwindcss = require("plugins.lsp.servers.tailwindcss"),
  yamlls = NIL,
}

if env.NVIM_USER_USE_VTSLS then
  M.servers.vtsls = NIL
else
  M.servers.tsserver = NIL
end

M.formatters = {
  -- "eslint_d",
  "prettierd",
}

return M
