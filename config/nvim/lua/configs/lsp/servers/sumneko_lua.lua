-- Setup neodev for annotations and vim api completions
require("neodev").setup({ library = { plugins = false } })

local M = {
    settings = {
        Lua = {
            completion = {
                callSnippet = "Disable",
            },
        },
    },
}

return M
