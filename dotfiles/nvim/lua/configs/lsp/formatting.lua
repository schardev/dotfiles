local M = {}
local nnoremap = require("core.utils").nnoremap
local vnoremap = require("core.utils").vnoremap
local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command

-- Use formatters from null-ls only
local lsp_formatting = function(bufnr)
    if not vim.b.format_on_save then
        return
    end
    vim.lsp.buf.format({
        name = "null-ls", -- Restrict formatting to client matching this name
        bufnr = bufnr,
    })
end

M.attach = function(client, bufnr)
    if not client.supports_method("textDocument/formatting") then
        return
    end

    -- Expose buffer-scoped variable to control autoformatting
    vim.b.format_on_save = true

    command("LspAutoFormatToggle", function()
        if not vim.b.format_on_save then
            vim.notify("Enabling auto-formatting!")
        else
            vim.notify("Disabling auto-formatting!")
        end
        vim.b.format_on_save = not vim.b.format_on_save
    end, { desc = "Toggle auto-formatting" })

    nnoremap("<LocalLeader>f", function()
        lsp_formatting(bufnr)
    end, { buffer = bufnr, desc = "Format" })

    vnoremap("<LocalLeader>f", function()
        -- TODO: Either merge this into lsp_formatting or filter out clients
        -- @see https://github.com/neovim/neovim/issues/18371
        vim.lsp.buf.range_formatting()
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
