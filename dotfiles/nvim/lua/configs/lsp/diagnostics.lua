local M = {}

-- Set diagnostic signs
local diagnostics_signs = {
    Error = " ",
    Warn = " ",
    Hint = " ",
    Info = " ",
}

-- Diagnostic float options (for vim.diagnostic.open_float)
local diagnostics_float_config = {
    border = "rounded",
    close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    focusable = false,
    -- header = "",
    -- prefix = function(diagnostic)
    --     local severity = diagnostics_signs[diagnostic.severity]
    --     local sname = vim.tbl_keys(severity)[1]
    --     local hl = "DiagnosticSign" .. sname
    --     return severity[sname], hl
    -- end,
    scope = "line",
    source = "always",
}

-- Show the popup diagnostics window, but only once for the current cursor location
-- by checking whether the word under the cursor has changed.
-- (Thanks @akinsho)
function M.diagnostics_float_handler()
    -- Immediately return if the screen width can show virtual text
    -- Mostly done for window splits and termux
    if vim.fn.winwidth(0) > 100 then
        return
    end

    local cword = vim.fn.expand("<cword>")
    if cword ~= vim.w.lsp_diagnostics_cword then
        vim.w.lsp_diagnostics_cword = cword
        local _, winnr = vim.diagnostic.open_float(diagnostics_float_config)
        if winnr ~= nil then
            vim.api.nvim_win_set_option(winnr, "winblend", 20)
        end
    end
end

function M.setup()
    for type, icon in pairs(diagnostics_signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- Global diagnostic config
    vim.diagnostic.config({
        virtual_text = function()
            -- Disable virtual text on smaller screens
            return vim.fn.winwidth(0) > 100
        end,
        float = diagnostics_float_config,
        underline = {
            -- Do not underline text when severity is low (INFO or HINT).
            severity = { min = vim.diagnostic.severity.WARN },
        },
    })
end

return M
