-- List of servers to install and setup automatically
local NIL = {} -- to avoid creating a new unique table everytime
local servers = {
  cssls = NIL,
  cssmodules_ls = NIL,
  dockerls = NIL,
  emmet_ls = require("plugins.lsp.servers.emmet_ls"),
  html = NIL,
  jsonls = require("plugins.lsp.servers.jsonls"),
  sumneko_lua = require("plugins.lsp.servers.sumneko_lua"),
  tsserver = require("plugins.lsp.servers.tsserver"),
  yamlls = NIL,
}
local on_attach = require("plugins.lsp.events").on_attach

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- LSP, Formatters, DAP installer
      {
        "williamboman/mason.nvim",
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

      -- Mason - lspconfig bridge
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = vim.tbl_keys(servers),
        },
      },

      -- Neovim api completions
      {
        "folke/neodev.nvim",
        opts = { library = { plugins = false } },
      },
    },
    config = function()
      -- Set global updatetime (null-ls and nvim-cmp also depends on it)
      vim.opt.updatetime = 400

      local lspconfig = require("lspconfig")
      local handlers = require("plugins.lsp.handlers")
      local diagnostics = require("plugins.lsp.diagnostics")

      -- Setup handlers and diagnostics config
      handlers.setup()
      diagnostics.setup()

      -- Update capabilities
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.completion =
        { completionItem = { snippetSupport = true } }

      -- Setup all listed servers
      for lsp, server in pairs(servers) do
        if lsp ~= "tsserver" then
          lspconfig[lsp].setup(
            vim.tbl_deep_extend("force", server.config or {}, {
              on_attach = on_attach,
              capabilities = capabilities,
              flags = {
                debounce_text_changes = vim.o.updatetime,
              },
            })
          )
        end
      end
    end,
  },

  -- Typescript helper commands
  {
    "jose-elias-alvarez/typescript.nvim",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    dependencies = { "nvim-lspconfig" },
    opts = {
      debug = false,
      server = {
        on_attach = on_attach,
      },
    },
  },
}
