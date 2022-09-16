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

function M.mapper_factory(mode)
    local default_opts = { silent = true }

    return function(lhs, rhs, opts)
        local final_opts = vim.tbl_extend("force", default_opts, opts or {})
        vim.keymap.set(mode, lhs, rhs, final_opts)
    end
end

return M
