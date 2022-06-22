-- Set global updatetime (null-ls and nvim-cmp also depends on it)
vim.opt.updatetime = 400

local lspconfig = require("lspconfig")
local handlers = require("configs.lsp.handlers")
local diagnostics = require("configs.lsp.diagnostics")
local on_attach = require("configs.lsp.events").on_attach

-- List of servers to install and setup automatically
local servers = {
    "cssls",
    "cssmodules_ls",
    "dockerls",
    "emmet_ls",
    "html",
    "jsonls",
    "sumneko_lua",
    "tsserver",
    "yamlls",
}

require("nvim-lsp-installer").setup({
    ensure_installed = servers,
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗",
        },
    },
})

-- Setup handlers and diagnostics config
handlers.setup()
diagnostics.setup()

-- Update capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Setup all listed servers
for _, lsp in pairs(servers) do
    local configured, lsp_settings = pcall(
        require,
        "configs.lsp.servers." .. lsp
    )

    if not configured then
        lsp_settings = {}
    end

    lspconfig[lsp].setup(vim.tbl_deep_extend("force", lsp_settings, {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = vim.o.updatetime,
        },
    }))
end
