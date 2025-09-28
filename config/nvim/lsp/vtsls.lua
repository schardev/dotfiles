local ts_ls_config = vim.lsp.config.ts_ls.settings

-- https://github.com/yioneko/vtsls/blob/main/packages/service/configuration.schema.json
---@type vim.lsp.Config
return {
  settings = vim.tbl_extend("force", ts_ls_config, {
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
  }),
}
