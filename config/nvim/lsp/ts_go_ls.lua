local ts_ls_config = vim.lsp.config.ts_ls

---@type vim.lsp.Config
local ts_go_config = {
  init_options = { hostInfo = "neovim" },
  cmd = { "tsgo", "--lsp", "--stdio" },
}

return vim.tbl_extend("force", ts_ls_config, ts_go_config)
