local M = {}
local nnoremap = require("core.utils").mapper_factory("n")
local vnoremap = require("core.utils").mapper_factory("v")

M.attach = function(client, bufnr)
  if client.supports_method("textDocument/publishDiagnostics") then
    nnoremap(
      "<LocalLeader>q",
      vim.diagnostic.setloclist,
      { desc = "Add buffer diagnostics to the location list" }
    )
    nnoremap("]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
    nnoremap("[d", vim.diagnostic.goto_prev, { desc = "Go to prev diagnostic" })
    nnoremap("<LocalLeader>dd", function()
      if vim.b.diagnostics_status then
        vim.diagnostic.disable(bufnr)
      else
        vim.diagnostic.enable(bufnr)
      end
      vim.b.diagnostics_status = not vim.b.diagnostics_status
    end, { desc = "Toggle diagnostics" })
  end

  nnoremap(
    "<LocalLeader>ca",
    vim.lsp.buf.code_action,
    { buffer = bufnr, desc = "Code action" }
  )
  vnoremap(
    "<LocalLeader>ca",
    vim.lsp.buf.range_code_action,
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
  nnoremap("D", vim.lsp.buf.hover, { buffer = bufnr })
  nnoremap(
    "gi",
    vim.lsp.buf.implementation,
    { buffer = bufnr, desc = "Go to implementation" }
  )
  nnoremap("<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr })

  if client.supports_method("textDocument/hover") then
    nnoremap(
      "<LocalLeader>D",
      vim.lsp.buf.type_definition,
      { buffer = bufnr, desc = "Go to type definition" }
    )
  end

  nnoremap(
    "<LocalLeader>rn",
    vim.lsp.buf.rename,
    { buffer = bufnr, desc = "Rename symbol under cursor" }
  )

  nnoremap(
    "gr",
    vim.lsp.buf.references,
    { buffer = bufnr, desc = "List all references" }
  )

  if client.name == "tsserver" then
    require("plugins.lsp.servers.tsserver").mappings(bufnr)
  end
end

return M
