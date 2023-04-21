local M = {}
local lsp_util = require("lspconfig.util")

M.config = {
  root_dir = function(fname)
    return lsp_util.root_pattern(
      "tailwind.config.js",
      "tailwind.config.cjs",
      "tailwind.config.mjs"
    )(fname)
  end,
}

return M
