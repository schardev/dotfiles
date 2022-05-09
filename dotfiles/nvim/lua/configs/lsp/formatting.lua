local M = {}
local nnoremap = require("core.utils").nnoremap
local autocmd = vim.api.nvim_create_autocmd

-- Expose global variable to control autoformatting
vim.g.format_on_save = true

-- Use formatters from null-ls only
local lsp_formatting = function(bufnr)
    if not vim.g.format_on_save then
        return
    end
    vim.lsp.buf.format({
        filter = function(clients)
            -- filter out unwanted clients
            return vim.tbl_filter(function(client)
                return client.name == "null-ls"
            end, clients)
        end,
        bufnr = bufnr,
    })
end

M.attach = function(client, bufnr)
    if not client.supports_method("textDocument/formatting") then
        return
    end
    nnoremap("<LocalLeader>f", function()
        lsp_formatting(bufnr)
    end, { buffer = bufnr, desc = "Format" })

    autocmd("BufWritePre", {
        group = "MyLocalLSPGroup",
        buffer = bufnr,
        callback = function()
            lsp_formatting(bufnr)
        end,
        desc = "Format file on save",
    })
end

return M
