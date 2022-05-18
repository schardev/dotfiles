local M = {}
local autocmd = vim.api.nvim_create_autocmd
local lsp_augroup = vim.api.nvim_create_augroup("MyLocalLSPGroup", {})

M.attach = function(client, bufnr)
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

    autocmd("CursorHold", {
        group = lsp_augroup,
        buffer = bufnr,
        callback = function()
            if vim.fn.winwidth(0) > 100 then
                return
            end
            local opts = {
                focusable = false,
                close_events = {
                    "BufLeave",
                    "CursorMoved",
                    "InsertEnter",
                    "FocusLost",
                },
                border = "rounded",
                source = "always",
                prefix = "",
                scope = "line",
            }
            vim.diagnostic.open_float(nil, opts)
        end,
        desc = "Shows diagnostic in floating window on smaller windows",
    })
end

return M
