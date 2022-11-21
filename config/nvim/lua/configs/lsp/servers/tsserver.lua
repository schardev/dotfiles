local M = {}
local nnoremap = require("core.utils").mapper_factory("n")

M.setup = function(on_attach)
    require("typescript").setup({
        debug = false,
        server = {
            on_attach = on_attach,
        },
    })
end

M.mappings = function(bufnr)
    -- Mappings
    nnoremap(
        "<LocalLeader>rf",
        "<Cmd>TypescriptRenameFile<CR>",
        { buffer = bufnr, desc = "Rename File" }
    )
    nnoremap(
        "gd",
        "<Cmd>TypescriptGoToSourceDefinition<CR>",
        { buffer = bufnr, desc = "Go To Source Definition" }
    )
    nnoremap(
        "<LocalLeader>mi",
        "<Cmd>TypescriptAddMissingImports<CR>",
        { buffer = bufnr, desc = "Add Missing Imports" }
    )
    nnoremap(
        "<LocalLeader>oi",
        "<Cmd>TypescriptOrganizeImports<CR>",
        { buffer = bufnr, desc = "Organize Imports" }
    )
    nnoremap(
        "<LocalLeader>ru",
        "<Cmd>TypescriptRemoveUnused<CR>",
        { buffer = bufnr, desc = "Remove Unused" }
    )
end
return M
