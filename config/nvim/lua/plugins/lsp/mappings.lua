local M = {}
local map = require("core.utils").map

M.attach = function(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if not client then
    return
  end

  local bufnr = args.buf
  local lsp_utils = require("plugins.lsp.utils")

  map(
    "n",
    "<LocalLeader>wa",
    vim.lsp.buf.add_workspace_folder,
    { buffer = bufnr, desc = "LSP: Add workspace folder" }
  )
  map(
    "n",
    "<LocalLeader>wr",
    vim.lsp.buf.remove_workspace_folder,
    { buffer = bufnr, desc = "LSP: Remove workspace folder" }
  )
  map("n", "<LocalLeader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { buffer = bufnr, desc = "LSP: Print workspace folders" })

  map(
    "n",
    "gD",
    vim.lsp.buf.declaration,
    { buffer = bufnr, desc = "LSP: Go to declaration" }
  )
  map(
    "n",
    "gd",
    vim.lsp.buf.definition,
    { buffer = bufnr, desc = "LSP: Go to definition" }
  )

  map(
    "n",
    "grt",
    vim.lsp.buf.type_definition,
    { buffer = bufnr, desc = "LSP: Go to type definition" }
  )

  if
    client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint)
  then
    map("n", "<leader>th", function()
      local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
      vim.lsp.inlay_hint.enable(not is_enabled)
      require("fidget").notify(
        (is_enabled and "Disabled" or "Enabled") .. " inlay hint",
        vim.log.levels.INFO
      )
    end, "LSP: Toggle inlay hints")
  end

  if client.name == "ts_ls" or client.name == "vtsls" then
    local ts_mappings = lsp_utils.generate_ts_mappings(client.name)

    map(
      "n",
      "<LocalLeader>oi",
      ts_mappings.organize_imports,
      { buffer = bufnr, desc = "LSP: Organize Imports" }
    )
    map(
      "n",
      "<LocalLeader>rf",
      ts_mappings.rename_file,
      { buffer = bufnr, desc = "LSP: Rename File" }
    )
    map(
      "n",
      "<LocalLeader>gd",
      ts_mappings.go_to_source_definition,
      { buffer = bufnr, desc = "LSP: Go To Source Definition" }
    )
    map(
      "n",
      "<LocalLeader>mi",
      ts_mappings.add_missing_imports,
      { buffer = bufnr, desc = "LSP: Add Missing Imports" }
    )
    map(
      "n",
      "<LocalLeader>ru",
      ts_mappings.remove_unused_imports,
      { buffer = bufnr, desc = "LSP: Remove Unused" }
    )
  end
end

return M
