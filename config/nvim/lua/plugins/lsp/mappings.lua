local M = {}
local map = require("core.utils").map
local methods = vim.lsp.protocol.Methods

---@param args vim.api.keyset.create_autocmd.callback_args
M.attach = function(args)
  local client = vim.lsp.get_client_by_id(args.data.client_id)
  if not client then
    return
  end

  local bufnr = args.buf
  local lsp_utils = require("plugins.lsp.utils")

  map(
    "n",
    "<localleader>wa",
    vim.lsp.buf.add_workspace_folder,
    { buffer = bufnr, desc = "LSP: Add workspace folder" }
  )
  map(
    "n",
    "<localleader>wr",
    vim.lsp.buf.remove_workspace_folder,
    { buffer = bufnr, desc = "LSP: Remove workspace folder" }
  )
  map("n", "<localleader>wl", function()
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

  map(
    "n",
    "grr",
    "<cmd>Telescope lsp_references<cr>",
    { buffer = bufnr, desc = "LSP: Go to references" }
  )

  if client:supports_method(methods.textDocument_inlayHint) then
    map("n", "<leader>ti", function()
      local is_enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
      vim.lsp.inlay_hint.enable(not is_enabled)

      vim.notify(
        string.format("%s inlay hint", (is_enabled and "Disabled" or "Enabled")),
        vim.log.levels.INFO
      )
    end, "LSP: Toggle inlay hints")
  end

  if client.name == "ts_ls" or client.name == "vtsls" then
    local ts_mappings = lsp_utils.generate_ts_mappings(client.name)

    map(
      "n",
      "<localleader>oi",
      ts_mappings.organize_imports,
      { buffer = bufnr, desc = "LSP: Organize Imports" }
    )
    map(
      "n",
      "<localleader>rf",
      ts_mappings.rename_file,
      { buffer = bufnr, desc = "LSP: Rename File" }
    )
    map(
      "n",
      "<localleader>gd",
      ts_mappings.go_to_source_definition,
      { buffer = bufnr, desc = "LSP: Go To Source Definition" }
    )
    map(
      "n",
      "<localleader>mi",
      ts_mappings.add_missing_imports,
      { buffer = bufnr, desc = "LSP: Add Missing Imports" }
    )
    map(
      "n",
      "<localleader>ru",
      ts_mappings.remove_unused_imports,
      { buffer = bufnr, desc = "LSP: Remove Unused" }
    )
  end
end

return M
