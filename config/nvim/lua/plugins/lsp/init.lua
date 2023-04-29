local env = require("core.env")

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- LSP, Formatters, DAP installer
      {
        "williamboman/mason.nvim",
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

          local ensure_installed = {
            -- lsp
            "css-lsp",
            "cssmodules-language-server",
            "dockerfile-language-server",
            "emmet-ls",
            "html-lsp",
            "json-lsp",
            "lua-language-server",
            "tailwindcss-language-server",
            "typescript-language-server",
            "vtsls",
            "yaml-language-server",

            -- formatters
            "eslint_d",
            "prettierd",
          }

          vim.api.nvim_create_user_command("MasonInstallAll", function()
            vim.cmd("MasonInstall " .. table.concat(ensure_installed, " "))
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

          -- TODO: Temporarily disable semantic tokens
          vim.lsp.get_client_by_id(args.data.client_id).server_capabilities.semanticTokensProvider =
            nil

          lsp_autocmds.attach(args)
          lsp_formatting.attach(args)
          lsp_mappings.attach(args)
        end,
      })

      -- Setup all listed servers
      local servers = {
        "cssls",
        "cssmodules_ls",
        "dockerls",
        "emmet_ls",
        "html",
        "jsonls",
        "lua_ls",
        "tailwindcss",
        "yamlls",
      }

      if env.NVIM_USER_USE_VTSLS then
        table.insert(servers, "vtsls")
      end

      for _, lsp in pairs(servers) do
        local present, server = pcall(require, "plugins.lsp.servers." .. lsp)
        lspconfig[lsp].setup(
          vim.tbl_deep_extend("force", present and server.config or {}, {
            capabilities = capabilities,
          })
        )
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
