local M = {}
local autocmds = require("configs.lsp.autocmds")
local mappings = require("configs.lsp.mappings")
local formatting = require("configs.lsp.formatting")

M.on_attach = function(client, bufnr)
    -- Clear any autocmd declared by previous client
    vim.api.nvim_clear_autocmds({
        group = "MyLocalLSPGroup",
        buffer = bufnr,
    })

    autocmds.attach(client, bufnr)
    formatting.attach(client, bufnr)
    mappings.attach(client, bufnr)
end

return M
