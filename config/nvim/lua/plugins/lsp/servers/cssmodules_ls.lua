local M = {}

M.config = {
  -- only enable css modules for jsx file as it'll conflict with tsserver in tsx files
  filetypes = { "javascriptreact" },
}

return M
