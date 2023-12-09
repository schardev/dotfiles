local env = require("core.env")

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- schemas
      "b0o/schemastore.nvim",

      -- LSP, Formatters, DAP installer
      {
        "williamboman/mason.nvim",
        dependencies = { "williamboman/mason-lspconfig.nvim" },
        build = ":MasonUpdate",
        config = function()
          require("mason").setup({
            ui = {
              border = "rounded",
              icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗",
              },
            },
          })

          local packages = require("plugins.lsp.packages")
          local lspconfig_to_package =
            require("mason-lspconfig.mappings.server").lspconfig_to_package
          local packages_to_install =
            vim.tbl_extend("force", packages.formatters, {})

          for lsp_name, _ in pairs(packages.servers) do
            table.insert(packages_to_install, lspconfig_to_package[lsp_name])
          end

          vim.api.nvim_create_user_command("MasonInstallAll", function()
            vim.cmd("MasonInstall " .. table.concat(packages_to_install, " "))
          end, {})
        end,
      },

      -- Neovim API completions
      {
        "folke/neodev.nvim",
        opts = { library = { plugins = false } },
      },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local lsp_handlers = require("plugins.lsp.handlers")
      local lsp_diagnostics = require("plugins.lsp.diagnostics")
      local lsp_autocmds = require("plugins.lsp.autocmds")
      local lsp_formatting = require("plugins.lsp.formatting")
      local lsp_mappings = require("plugins.lsp.mappings")
      local lsp_servers = require("plugins.lsp.packages").servers

      -- Setup handlers and diagnostics config
      lsp_handlers.setup()
      lsp_diagnostics.setup()

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

          -- TODO: Temporarily disable semantic tokens
          -- vim.lsp.get_client_by_id(args.data.client_id).server_capabilities.semanticTokensProvider =
          --   nil

          lsp_autocmds.attach(args)
          lsp_formatting.attach(args)
          lsp_mappings.attach(args)
        end,
      })

      for lsp, config in pairs(lsp_servers) do
        lspconfig[lsp].setup(vim.tbl_deep_extend("force", config, {
          capabilities = capabilities,
        }))
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
    enabled = not env.NVIM_USER_USE_VTSLS,
    dependencies = { "nvim-lspconfig" },
    opts = {
      debug = false,
    },
  },

  {
    "yioneko/nvim-vtsls",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    enabled = env.NVIM_USER_USE_VTSLS,
    dependencies = { "nvim-lspconfig" },
  },
}
