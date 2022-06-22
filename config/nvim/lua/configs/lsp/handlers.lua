local M = {}

M.setup = function()
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers["textDocument/hover"],
        {
            border = "rounded",
        }
    )

    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers["textDocument/signatureHelp"],
        {
            border = "rounded",
        }
    )
end

return M
