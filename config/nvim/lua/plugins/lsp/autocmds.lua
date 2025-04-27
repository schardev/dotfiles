local M = {}

local autocmd = vim.api.nvim_create_autocmd
M.lsp_attach_augroup_id = vim.api.nvim_create_augroup("user.lsp.attach", {})
M.lsp_detach_augroup_id = vim.api.nvim_create_augroup("user.lsp.detach", {})

M.attach = function(args)
  local bufnr = args.buf
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  local methods = vim.lsp.protocol.Methods
  local highlight_augroup_id =
    vim.api.nvim_create_augroup("user.lsp.document-highlight", {})

  if not client then
    return
  end

  if client:supports_method(methods.textDocument_documentHighlight) then
    autocmd({ "CursorHold", "CursorHoldI" }, {
      group = highlight_augroup_id,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
      desc = "Highlights symbol under cursor",
    })

    autocmd("CursorMoved", {
      group = highlight_augroup_id,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
      desc = "Clears symbol highlighting under cursor",
    })

    autocmd("LspDetach", {
      group = M.lsp_detach_augroup_id,
      callback = function(e)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds({
          group = highlight_augroup_id,
          buffer = e.buf,
        })
      end,
    })
  end
end

return M
