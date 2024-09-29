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
    },
    config = function()
      local lspconfig = require("lspconfig")
      local lsp_handlers = require("plugins.lsp.handlers")
      local lsp_diagnostics = require("plugins.lsp.diagnostics")
      local lsp_autocmds = require("plugins.lsp.autocmds")
      local lsp_mappings = require("plugins.lsp.mappings")
      local lsp_servers = require("plugins.lsp.packages").servers

      -- Update capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend(
        "force",
        capabilities,
        require("cmp_nvim_lsp").default_capabilities()
      )

      -- Setup handlers and diagnostics config
      lsp_handlers.setup()
      lsp_diagnostics.setup()

      -- Attach callbacks
      vim.api.nvim_create_autocmd("LspAttach", {
        group = lsp_autocmds.lsp_attach_augroup_id,
        callback = function(args)
          lsp_autocmds.attach(args)
          lsp_mappings.attach(args)
        end,
      })

      for lsp, opts in pairs(lsp_servers) do
        lspconfig[lsp].setup(vim.tbl_deep_extend("force", opts.config or {}, {
          capabilities = capabilities,
        }))
      end
    end,
  },

  {
    "yioneko/nvim-vtsls",
    ft = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
    enabled = not env.NVIM_USER_USE_TS_LS,
    dependencies = { "nvim-lspconfig" },
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
  { "Bilal2453/luvit-meta", lazy = true },
}
