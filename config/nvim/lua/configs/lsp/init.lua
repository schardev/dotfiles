-- Set global updatetime (null-ls and nvim-cmp also depends on it)
vim.opt.updatetime = 400

local lspconfig = require("lspconfig")
local handlers = require("configs.lsp.handlers")
local diagnostics = require("configs.lsp.diagnostics")
local on_attach = require("configs.lsp.events").on_attach

-- List of servers to install and setup automatically
local NIL = {} -- to avoid creating a new unique table everytime
local servers = {
    cssls = NIL,
    cssmodules_ls = NIL,
    dockerls = NIL,
    emmet_ls = require("configs.lsp.servers.emmet_ls"),
    html = NIL,
    jsonls = require("configs.lsp.servers.jsonls"),
    sumneko_lua = require("configs.lsp.servers.sumneko_lua"),
    tsserver = require("configs.lsp.servers.tsserver"),
    yamlls = NIL,
}

-- Mason config
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

require("mason-lspconfig").setup({
    ensure_installed = vim.tbl_keys(servers),
})

-- Setup handlers and diagnostics config
handlers.setup()
diagnostics.setup()

-- Update capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities.textDocument.completion =
    { completionItem = { snippetSupport = true } }

-- Setup all listed servers
for lsp, server in pairs(servers) do
    if lsp == "tsserver" then
        require("configs.lsp.servers.tsserver").setup(on_attach)
    else
        lspconfig[lsp].setup(vim.tbl_deep_extend("force", server.config or {}, {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = vim.o.updatetime,
            },
        }))
    end
end
