local M = {}
local mapper = require("core.utils").mapper_factory
local lsp_autocmds = require("plugins.lsp.autocmds")
local autocmd = vim.api.nvim_create_autocmd
local command = vim.api.nvim_create_user_command

-- Use formatters from null-ls only
local lsp_format = function(bufnr)
  vim.lsp.buf.format({
    name = "null-ls", -- Restrict formatting to client matching this name
    bufnr = bufnr,
  })
end

M.attach = function(args)
  local bufnr = args.buf
  local client = vim.lsp.get_client_by_id(args.data.client_id)

  -- Exit immediately if the client doesn't support formatting
  if not client.server_capabilities.documentFormattingProvider then
    return
  end

  -- Expose buffer-scoped variable to control autoformatting
  vim.b.format_on_save = true

  command("UserLspAutoFormatToggle", function()
    if not vim.b.format_on_save then
      vim.notify("Enabling auto-formatting!")
    else
      vim.notify("Disabling auto-formatting!")
    end
    vim.b.format_on_save = not vim.b.format_on_save
  end, { desc = "Toggle auto-formatting" })

  mapper({ "n", "v" })("<LocalLeader>f", function()
    lsp_format(bufnr)
  end, { buffer = bufnr, desc = "Format" })

  autocmd("BufWritePre", {
    group = lsp_autocmds.lsp_augroup_id,
    buffer = bufnr,
    callback = function()
      if not vim.b.format_on_save then
        return
      end
      lsp_format(bufnr)
    end,
    desc = "Format file on save",
  })
end

return M
