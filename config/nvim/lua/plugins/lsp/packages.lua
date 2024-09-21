local env = require("core.env")
local M = {}
local NIL = {}

-- Server names are according to lspconfig (see `:h lspconfig-all`)
M.servers = {
  cssls = NIL,
  -- cssmodules_ls = NIL,
  dockerls = NIL,
  emmet_language_server = require("plugins.lsp.servers.emmet_ls"),
  eslint = require("plugins.lsp.servers.eslint"),
  html = NIL,
  jsonls = require("plugins.lsp.servers.jsonls"),
  lua_ls = require("plugins.lsp.servers.lua_ls"),
  tailwindcss = require("plugins.lsp.servers.tailwindcss"),
  yamlls = NIL,
}

if env.NVIM_USER_USE_TS_LS then
  M.servers.ts_ls = require("plugins.lsp.servers.tsserver")
else
  M.servers.vtsls = require("plugins.lsp.servers.tsserver")
end

M.formatters = {
  -- "eslint_d",
  "prettierd",
}

return M
