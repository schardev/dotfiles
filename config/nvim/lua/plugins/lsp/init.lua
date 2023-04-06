-- List of servers to install and setup automatically
local NIL = {} -- to avoid creating a new unique table every time
local servers = {
  cssls = NIL,
  cssmodules_ls = NIL,
  dockerls = NIL,
  emmet_ls = require("plugins.lsp.servers.emmet_ls"),
  html = NIL,
  jsonls = require("plugins.lsp.servers.jsonls"),
  lua_ls = require("plugins.lsp.servers.lua_ls"),
  tsserver = NIL,
  yamlls = NIL,
}

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
          ensure_installed = vim.tbl_filter(function(server)
            if vim.env.IS_TERMUX and server == "lua_ls" then
              return false
            end
            return true
          end, vim.tbl_keys(servers)),
        },
      },

      -- Neovim API completions
      {
        "folke/neodev.nvim",
        opts = { library = { plugins = false } },
      },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local handlers = require("plugins.lsp.handlers")
      local diagnostics = require("plugins.lsp.diagnostics")
      local lsp_autocmds = require("plugins.lsp.autocmds")
      local lsp_formatting = require("plugins.lsp.formatting")
      local lsp_mappings = require("plugins.lsp.mappings")

      -- Setup handlers and diagnostics config
      handlers.setup()
      diagnostics.setup()

      -- Update capabilities
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      capabilities.textDocument.completion =
        { completionItem = { snippetSupport = true } }

      -- Attach callbacks
      local autocmd = vim.api.nvim_create_autocmd
      autocmd("LspAttach", {
        group = lsp_autocmds.lsp_augroup_id,
        callback = function(args)
          -- Clear any autocmd declared by previous client
          -- TODO: file an issue upstream with repro
          if
            pcall(
              vim.api.nvim_get_autocmds,
              { group = lsp_autocmds.lsp_augroup_id, buffer = args.buf }
            )
          then
            vim.api.nvim_clear_autocmds({
              group = lsp_autocmds.lsp_augroup_id,
              buffer = args.buf,
            })
          end

          lsp_autocmds.attach(args)
          lsp_formatting.attach(args)
          lsp_mappings.attach(args)
        end,
      })

      -- Setup all listed servers
      for lsp, server in pairs(servers) do
        if lsp ~= "tsserver" then
          lspconfig[lsp].setup(
            vim.tbl_deep_extend("force", server.config or {}, {
              capabilities = capabilities,
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
    },
  },
}
