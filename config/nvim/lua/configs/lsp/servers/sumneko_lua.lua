local M = {}

M = vim.tbl_deep_extend(
    "force",
    require("lua-dev").setup({ snippet = false }),
    {}
)

return M
