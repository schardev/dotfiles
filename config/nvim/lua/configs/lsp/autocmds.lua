local M = {}

local autocmd = vim.api.nvim_create_autocmd
local diagnostics_float_handler =
    require("configs.lsp.diagnostics").diagnostics_float_handler

M.attach = function(client, bufnr)
    local lsp_augroup = vim.api.nvim_create_augroup("MyLocalLSPGroup", {})
    if client.supports_method("textDocument/documentHighlight") then
        autocmd({ "CursorHold", "CursorHoldI" }, {
            group = lsp_augroup,
            buffer = bufnr,
            callback = vim.lsp.buf.document_highlight,
            desc = "Highlights symbol under cursor",
        })

        autocmd("CursorMoved", {
            group = lsp_augroup,
            buffer = bufnr,
            callback = vim.lsp.buf.clear_references,
            desc = "Clears symbol highlighting under cursor",
        })
    end

    if client.supports_method("textDocument/publishDiagnostics") then
        autocmd("CursorHold", {
            group = lsp_augroup,
            buffer = bufnr,
            callback = diagnostics_float_handler,
            desc = "Shows diagnostic in floating window on smaller windows",
        })
    end

    autocmd("LspDetach", {
        group = lsp_augroup,
        buffer = bufnr,
        callback = function()
            vim.api.nvim_del_augroup_by_id(lsp_augroup)
        end,
        desc = "Delete lsp autocmds after detaching client",
    })
end

return M
