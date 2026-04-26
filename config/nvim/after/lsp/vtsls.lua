local tsgo_config = vim.lsp.config.tsgo.settings

---@type lspconfig.settings.vtsls
local vtsls_config = {
  vtsls = {
    -- Automatically use workspace version of TypeScript lib on startup
    autoUseWorkspaceTsdk = true,
    experimental = {
      -- Truncate inlay hint
      -- https://github.com/neovim/neovim/issues/27240
      maxInlayHintLength = 40,
      completion = {
        -- Execute fuzzy match of completion items on server side. Enable this
        -- will help filter out useless completion items from tsserver
        enableServerSideFuzzyMatch = true,
        -- entriesLimit = 200,
      },
    },
  },
}

-- https://github.com/yioneko/vtsls/blob/main/packages/service/configuration.schema.json
---@type vim.lsp.Config
return {
  settings = vim.tbl_extend("force", tsgo_config, {
    vtsls = vtsls_config,
  }),
}
