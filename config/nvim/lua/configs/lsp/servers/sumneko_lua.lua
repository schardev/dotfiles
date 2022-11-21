-- Setup neodev for annotations and vim api completions
require("neodev").setup({ library = { plugins = false } })

local M = {}

M.config = {
    settings = {
        Lua = {
            completion = {
                callSnippet = "Disable",
            },
        },
    },
}

return M
