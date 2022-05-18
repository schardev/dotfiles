local M = {}

M = vim.tbl_deep_extend("force", require("lua-dev").setup({}), {
    settings = {
        Lua = {
            completion = { callSnippet = "Disable" },
            workspace = { maxPreload = nil },
        },
    },
})

return M
