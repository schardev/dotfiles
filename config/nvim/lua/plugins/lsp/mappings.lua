local M = {}
local mapper = require("core.utils").mapper_factory
local nnoremap = mapper("n")

M.attach = function(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if not client then
    return
  end

  local bufnr = args.buf
  local lsp_utils = require("plugins.lsp.utils")

  mapper({ "n", "v" })(
    "<LocalLeader>ca",
    vim.lsp.buf.code_action,
    { buffer = bufnr, desc = "LSf: Code action" }
  )
  nnoremap(
    "<LocalLeader>wa",
    vim.lsp.buf.add_workspace_folder,
    { buffer = bufnr, desc = "LSP: Add workspace folder" }
  )
  nnoremap(
    "<LocalLeader>wr",
    vim.lsp.buf.remove_workspace_folder,
    { buffer = bufnr, desc = "LSP: Remove workspace folder" }
  )
  nnoremap("<LocalLeader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { buffer = bufnr, desc = "LSP: Print workspace folders" })

  nnoremap("K", vim.lsp.buf.hover, { buffer = bufnr })
  nnoremap("<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr })
  nnoremap(
    "<LocalLeader>rn",
    vim.lsp.buf.rename,
    { buffer = bufnr, desc = "LSP: Rename symbol under cursor" }
  )

  nnoremap(
    "gD",
    vim.lsp.buf.declaration,
    { buffer = bufnr, desc = "LSP: Go to declaration" }
  )
  nnoremap(
    "gd",
    vim.lsp.buf.definition,
    { buffer = bufnr, desc = "LSP: Go to definition" }
  )
  nnoremap(
    "gi",
    vim.lsp.buf.implementation,
    { buffer = bufnr, desc = "LSP: Go to implementation" }
  )

  nnoremap(
    "gr",
    vim.lsp.buf.references,
    { buffer = bufnr, desc = "LSP: List all references" }
  )
  nnoremap(
    "gt",
    vim.lsp.buf.type_definition,
    { buffer = bufnr, desc = "LSP: Go to type definition" }
  )

  if
    client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint)
  then
    nnoremap("<leader>th", function()
      vim.lsp.inlay_hint.enable(
        not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
      )
    end, { desc = "LSP: Toggle inlay hints" })
  end

  if client.name == "ts_ls" or client.name == "vtsls" then
    local ts_mappings = lsp_utils.generate_ts_mappings(client.name)

    nnoremap(
      "<LocalLeader>oi",
      ts_mappings.organize_imports,
      { buffer = bufnr, desc = "LSP: Organize Imports" }
    )
    nnoremap(
      "<LocalLeader>rf",
      ts_mappings.rename_file,
      { buffer = bufnr, desc = "LSP: Rename File" }
    )
    nnoremap(
      "<LocalLeader>gd",
      ts_mappings.go_to_source_definition,
      { buffer = bufnr, desc = "LSP: Go To Source Definition" }
    )
    nnoremap(
      "<LocalLeader>mi",
      ts_mappings.add_missing_imports,
      { buffer = bufnr, desc = "LSP: Add Missing Imports" }
    )
    nnoremap(
      "<LocalLeader>ru",
      ts_mappings.remove_unused_imports,
      { buffer = bufnr, desc = "LSP: Remove Unused" }
    )
  end
end

return M
