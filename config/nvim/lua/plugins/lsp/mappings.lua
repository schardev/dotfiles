local M = {}
local map = require("core.utils").map
local methods = vim.lsp.protocol.Methods

---@param e vim.api.keyset.create_autocmd.callback_args
M.attach = function(e)
  local client = vim.lsp.get_client_by_id(e.data.client_id)
  if not client then
    return
  end

  local bufnr = e.buf
  local lsp_utils = require("plugins.lsp.utils")

  map("n", "K", function()
    vim.lsp.buf.hover({ border = "rounded" })
  end, { buf = bufnr, desc = "LSP: Hover" })

  map(
    "n",
    "<localleader>wa",
    vim.lsp.buf.add_workspace_folder,
    { buf = bufnr, desc = "LSP: Add workspace folder" }
  )
  map(
    "n",
    "<localleader>wr",
    vim.lsp.buf.remove_workspace_folder,
    { buf = bufnr, desc = "LSP: Remove workspace folder" }
  )
  map("n", "<localleader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, { buf = bufnr, desc = "LSP: Print workspace folders" })

  map(
    "n",
    "gD",
    vim.lsp.buf.declaration,
    { buf = bufnr, desc = "LSP: Go to declaration" }
  )
  map(
    "n",
    "gd",
    vim.lsp.buf.definition,
    { buf = bufnr, desc = "LSP: Go to definition" }
  )

  map(
    "n",
    "grr",
    "<cmd>Telescope lsp_references<cr>",
    { buf = bufnr, desc = "LSP: Go to references" }
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

  if client:supports_method(methods.textDocument_codeLens) then
    map("n", "<leader>te", function()
      local is_enabled = vim.lsp.codelens.is_enabled({ bufnr = bufnr })
      vim.lsp.codelens.enable(not is_enabled)

      vim.notify(
        string.format("%s codelens", (is_enabled and "Disabled" or "Enabled")),
        vim.log.levels.INFO
      )
    end, "LSP: Toggle codelens")
  end

  if client.name == "ts_ls" or client.name == "vtsls" then
    local ts_mappings = lsp_utils.generate_ts_mappings(client.name)

    map(
      "n",
      "<localleader>oi",
      ts_mappings.organize_imports,
      { buf = bufnr, desc = "LSP: Organize Imports" }
    )
    map(
      "n",
      "<localleader>rf",
      ts_mappings.rename_file,
      { buf = bufnr, desc = "LSP: Rename File" }
    )
    map(
      "n",
      "<localleader>gd",
      ts_mappings.go_to_source_definition,
      { buf = bufnr, desc = "LSP: Go To Source Definition" }
    )
    map(
      "n",
      "<localleader>mi",
      ts_mappings.add_missing_imports,
      { buf = bufnr, desc = "LSP: Add Missing Imports" }
    )
    map(
      "n",
      "<localleader>ru",
      ts_mappings.remove_unused_imports,
      { buf = bufnr, desc = "LSP: Remove Unused" }
    )
  end
end

return M
