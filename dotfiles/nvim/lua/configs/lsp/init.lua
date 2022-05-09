-- Set global updatetime (null-ls and nvim-cmp also depends on it)
vim.opt.updatetime = 400

local lspconfig = require("lspconfig")
local handlers = require("configs.lsp.handlers")
local on_attach = require("configs.lsp.event").on_attach

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

-- Setup handlers
handlers.setup()

-- Update capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Set diagnostic signs
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Disable diagnostic virtual text on smaller screen
-- TODO: Set it locally for each invocation instead of globally
vim.diagnostic.config({
    virtual_text = true,
    float = {
        source = "always",
    },
})
if vim.fn.winwidth(0) < 100 then
    vim.diagnostic.config({ virtual_text = false })
end

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

-- TODO: Merge sumneko_lua setup to global server setup below
lspconfig.sumneko_lua.setup(
    vim.tbl_deep_extend("force", require("lua-dev").setup({}), {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                completion = { callSnippet = "Disable" },
                workspace = { maxPreload = nil },
            },
        },
    })
)

-- Setup all listed servers
for _, lsp in pairs(servers) do
    if lsp ~= "sumneko_lua" then
        lspconfig[lsp].setup({
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = vim.o.updatetime,
            },
        })
    end
end
