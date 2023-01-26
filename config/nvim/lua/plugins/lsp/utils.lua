local M = {}

-- Spawn source command with lsp resolved root_dir
-- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/289
M.spawn_with_lsp_root = function(params, server)
  require("lspconfig")[server].get_root_dir(params.bufname)
end

return M
