local autocmd = vim.api.nvim_create_autocmd

-- Do not highlight whitespaces in below filetypes
local ignore_filetypes = {
    "help",
    "c",
    "gitcommit",
    "kconfig",
    "make",
    "TelescopePrompt",
}

autocmd({ "ColorScheme", "FileType" }, {
    pattern = "*",
    callback = function()
        if
            vim.tbl_contains(ignore_filetypes, vim.bo.filetype)
            or not vim.bo.modifiable
            or vim.bo.buftype == "nofile"
        then
            vim.fn.clearmatches()
            return
        end
        vim.g.tab_highlight = true
        vim.cmd([[ highlight ExtraWhitespace ctermbg=red guibg=red ]])
        vim.cmd([[ highlight Tabs ctermbg=yellow guibg=yellow ]])
        vim.cmd([[ match ExtraWhitespace /\s\+$/ ]])
        vim.fn.matchadd("Tabs", "\t")
    end,
})

autocmd("BufWinLeave", {
    pattern = "*",
    callback = function()
        vim.fn.clearmatches()
    end,
})
