local autocmd = vim.api.nvim_create_autocmd
local nnoremap = require("core.utils").nnoremap

local my_local_group = vim.api.nvim_create_augroup("MyLocalGroup", {
    clear = true,
})

autocmd("WinEnter", {
    group = my_local_group,
    pattern = "*",
    callback = function()
        vim.wo.cursorline = true
        vim.wo.colorcolumn = "80"
    end,
    desc = "Highlight cursorline and colorcolumn on active window",
})

autocmd("WinLeave", {
    group = my_local_group,
    pattern = "*",
    callback = function()
        vim.wo.cursorline = false
        vim.wo.colorcolumn = ""
    end,
    desc = "Remove cursorline and colorcolumn from inactive window",
})

autocmd("TermOpen", {
    group = my_local_group,
    pattern = "*",
    callback = function()
        vim.wo.number = false
        vim.wo.relativenumber = false
        vim.wo.signcolumn = "no"
    end,
    desc = "Disable line numbers in terminal window",
})

autocmd("BufEnter", {
    group = my_local_group,
    pattern = "*",
    callback = function(params)
        -- Map q to exit in non-filetype buffer
        if vim.bo.buftype == "nofile" or not vim.bo.modifiable then
            nnoremap("q", ":q<CR>", { buffer = params.buf })
        end

        -- Exit neovim if the last window is of NvimTree
        if
            vim.fn.winnr("$") == 1
            and vim.fn.bufname() == "NvimTree_" .. vim.fn.tabpagenr()
        then
            vim.cmd("quit")
        end
    end,
    desc = "Utils",
})

autocmd("TextYankPost", {
    group = my_local_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 400 })
    end,
    desc = "Highlight text on yank (copy)",
})
