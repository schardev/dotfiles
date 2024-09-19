local M = {}

local autocmd = vim.api.nvim_create_autocmd
M.lsp_augroup_id = vim.api.nvim_create_augroup("UserLspGroup", {})

M.attach = function(args)
  local bufnr = args.buf
  local client = vim.lsp.get_client_by_id(args.data.client_id)

  if
    client
    and client.supports_method(
      vim.lsp.protocol.Methods.textDocument_documentHighlight
    )
  then
    autocmd({ "CursorHold", "CursorHoldI" }, {
      group = M.lsp_augroup_id,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
      desc = "Highlights symbol under cursor",
    })

    autocmd("CursorMoved", {
      group = M.lsp_augroup_id,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
      desc = "Clears symbol highlighting under cursor",
    })
  end
end

return M
