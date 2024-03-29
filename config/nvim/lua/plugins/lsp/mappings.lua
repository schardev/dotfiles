local M = {}
local mapper = require("core.utils").mapper_factory
local nnoremap = mapper("n")

M.attach = function(args)
  local bufnr = args.buf
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  local lsp_utils = require("plugins.lsp.utils")
  vim.b[bufnr].show_diagnostics = true

  nnoremap(
    "<LocalLeader>q",
    vim.diagnostic.setloclist,
    { desc = "Add diagnostics to the location list" }
  )
  nnoremap("]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
  nnoremap("[d", vim.diagnostic.goto_prev, { desc = "Go to prev diagnostic" })
  nnoremap("<LocalLeader>dd", function()
    if vim.b.show_diagnostics then
      vim.notify("[LSP] Disabled diagnostics.", vim.log.levels.INFO)
      vim.diagnostic.disable(0)
    else
      vim.notify("[LSP] Enabled diagnostics.", vim.log.levels.INFO)
      vim.diagnostic.enable(0)
    end
    vim.b.show_diagnostics = not vim.b.show_diagnostics
  end, { desc = "Toggle diagnostics" })

  mapper({ "n", "v" })(
    "<LocalLeader>ca",
    vim.lsp.buf.code_action,
    { buffer = bufnr, desc = "Code action" }
  )
  nnoremap(
    "<LocalLeader>wa",
    vim.lsp.buf.add_workspace_folder,
    { buffer = bufnr, desc = "Add workspace folder" }
  )
  nnoremap(
    "<LocalLeader>wr",
    vim.lsp.buf.remove_workspace_folder,
    { buffer = bufnr, desc = "Remove workspace folder" }
  )
  nnoremap("<LocalLeader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { buffer = bufnr, desc = "Print workspace folders" })

  nnoremap("D", vim.lsp.buf.hover, { buffer = bufnr })
  nnoremap("<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr })

  nnoremap(
    "gD",
    vim.lsp.buf.declaration,
    { buffer = bufnr, desc = "Go to declaration" }
  )
  nnoremap(
    "gd",
    vim.lsp.buf.definition,
    { buffer = bufnr, desc = "Go to definition" }
  )
  nnoremap(
    "gi",
    vim.lsp.buf.implementation,
    { buffer = bufnr, desc = "Go to implementation" }
  )

  nnoremap(
    "gr",
    vim.lsp.buf.references,
    { buffer = bufnr, desc = "List all references" }
  )

  if client.server_capabilities.hoverProvider then
    nnoremap(
      "gt",
      vim.lsp.buf.type_definition,
      { buffer = bufnr, desc = "Go to type definition" }
    )
  end

  nnoremap(
    "<LocalLeader>rn",
    vim.lsp.buf.rename,
    { buffer = bufnr, desc = "Rename symbol under cursor" }
  )

  if client.name == "tsserver" or client.name == "vtsls" then
    local ts_mappings = lsp_utils.generate_ts_mappings(client.name)

    nnoremap(
      "<LocalLeader>oi",
      ts_mappings.organize_imports,
      { buffer = bufnr, desc = "Organize Imports" }
    )
    nnoremap(
      "<LocalLeader>rf",
      ts_mappings.rename_file,
      { buffer = bufnr, desc = "Rename File" }
    )
    nnoremap(
      "<LocalLeader>gd",
      ts_mappings.go_to_source_definition,
      { buffer = bufnr, desc = "Go To Source Definition" }
    )
    nnoremap(
      "<LocalLeader>mi",
      ts_mappings.add_missing_imports,
      { buffer = bufnr, desc = "Add Missing Imports" }
    )
    nnoremap(
      "<LocalLeader>ru",
      ts_mappings.remove_unused_imports,
      { buffer = bufnr, desc = "Remove Unused" }
    )
  end
end

return M
