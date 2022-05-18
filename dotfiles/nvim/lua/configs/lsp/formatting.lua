local M = {}
local nnoremap = require("core.utils").nnoremap
local vnoremap = require("core.utils").vnoremap
local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command

-- Expose global variable to control autoformatting
-- TODO: Make it local to buffer instead
vim.g.format_on_save = true

-- Use formatters from null-ls only
local lsp_formatting = function(bufnr)
    if not vim.g.format_on_save then
        return
    end
    vim.lsp.buf.format({
        -- filter = function(clients)
        --     -- filter out unwanted clients
        --     return vim.tbl_filter(function(client)
        --         return client.name == "null-ls"
        --     end, clients)
        -- end,
        name = "null-ls", -- Restrict formatting to client matching this name
        bufnr = bufnr,
    })
end

M.attach = function(client, bufnr)
    if not client.supports_method("textDocument/formatting") then
        return
    end

    command("LspAutoFormat", function()
        vim.g.format_on_save = not vim.g.format_on_save
    end, { desc = "Toggle auto-formatting" })

    nnoremap("<LocalLeader>f", function()
        lsp_formatting(bufnr)
    end, { buffer = bufnr, desc = "Format" })

    vnoremap("<LocalLeader>f", function()
        -- TODO: Either merge this into lsp_formatting or filter out clients
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
