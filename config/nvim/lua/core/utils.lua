local M = {}

function M.save_and_exec()
    if vim.bo.filetype == "vim" then
        vim.cmd([[
        silent! write
        source %
        ]])
    elseif vim.bo.filetype == "lua" then
        vim.cmd([[
        silent! write
        luafile %
        ]])
    end
end

function M.highlight(...)
    -- https://github.com/neovim/neovim/issues/18160
    vim.api.nvim_set_hl(0, ...)
end

local map = function(mode, lhs, rhs, opts)
    local default_opts = { silent = true }
    local final_opts = vim.tbl_extend("force", default_opts, opts or {})
    vim.keymap.set(mode, lhs, rhs, final_opts)
end

function M.map(mode, lhs, rhs, opts)
    map(mode, lhs, rhs, opts)
end

function M.inoremap(lhs, rhs, opts)
    map("i", lhs, rhs, opts)
end

function M.nnoremap(lhs, rhs, opts)
    map("n", lhs, rhs, opts)
end

function M.vnoremap(lhs, rhs, opts)
    map("v", lhs, rhs, opts)
end

function M.tnoremap(lhs, rhs, opts)
    map("t", lhs, rhs, opts)
end

return M
