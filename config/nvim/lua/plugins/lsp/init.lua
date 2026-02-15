---@type LazySpec
return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "mason-org/mason.nvim" },
    config = function()
      local lsp_diagnostics = require("plugins.lsp.diagnostics")
      local lsp_autocmds = require("plugins.lsp.autocmds")
      local lsp_mappings = require("plugins.lsp.mappings")
      local lsp_servers = require("plugins.lsp.packages").get_lsp_servers()

      -- Setup diagnostics config
      lsp_diagnostics.setup()

      -- Attach callbacks
      vim.api.nvim_create_autocmd("LspAttach", {
        group = lsp_autocmds.lsp_attach_augroup_id,
        callback = function(args)
          lsp_autocmds.attach(args)
          lsp_mappings.attach(args)
        end,
      })

      -- enable servers
      vim.schedule(function()
        for _, server in pairs(lsp_servers) do
          vim.lsp.enable(server)
        end
      end)
    end,
  },

  -- LSP, Formatters, DAP installer
  ---@module 'mason.nvim'
  {
    "mason-org/mason.nvim",
    build = ":MasonUpdate",
    ---@type MasonSettings
    opts = {
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    config = function()
      local lsp_servers = require("plugins.lsp.packages").get_lsp_servers()
      require("mason-lspconfig").setup({
        automatic_enable = false,
        ensure_installed = lsp_servers,
      })
    end,
  },

  -- Typescript server utils
  {
    "yioneko/nvim-vtsls",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    dependencies = { "nvim-lspconfig" },
    enabled = function()
      local env = require("core.env")
      return not env.NVIM_USER_USE_TS_GO_LS
    end,
  },

  -- Neovim API completions
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        { path = "luvit-meta/library", words = { "vim%.uv" } },
        "lazy.nvim",
      },
    },
  },

  -- libuv types
  { "Bilal2453/luvit-meta", lazy = true },

  -- schemas
  { "b0o/schemastore.nvim", lazy = true },
}
