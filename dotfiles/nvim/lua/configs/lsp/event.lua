local M = {}
local autocmds = require("configs.lsp.autocmds")
local mappings = require("configs.lsp.mappings")
local formatting = require("configs.lsp.formatting")

M.on_attach = function(client, bufnr)
    autocmds.attach(client, bufnr)
    mappings.attach(client, bufnr)
    formatting.attach(client, bufnr)
end

return M
