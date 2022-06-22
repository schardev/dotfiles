-- Mappings
local nnoremap = require("core.utils").nnoremap
local autocmd = vim.api.nvim_create_autocmd

nnoremap("<F1>", ":NvimTreeToggle<CR>", {
    desc = "Toggle NvimTree",
})
nnoremap("<Leader><F1>", ":NvimTreeFindFile<CR>", {
    desc = "Open current file tree in NvimTree",
})

local configs_nvimtree = vim.api.nvim_create_augroup("ConfigsNvimTree", {})
autocmd("BufEnter", {
    group = configs_nvimtree,
    pattern = "*",
    callback = function()
        -- Exit neovim if the last window is of NvimTree
        if
            vim.fn.winnr("$") == 1
            and vim.fn.bufname() == "NvimTree_" .. vim.fn.tabpagenr()
        then
            vim.cmd("quit")
        end
    end,
    desc = "Smartly exit NvimTree",
})

-- Main setup
require("nvim-tree").setup({
    disable_netrw = false,
    diagnostics = {
        enable = true,
    },

    actions = {
        open_file = {
            -- Auto-resize on opening file
            resize_window = true,
        },
    },

    -- Do not show hidden files by default (can be toggled by `H`)
    filters = {
        dotfiles = true,
    },

    -- Show files ignored by .gitignore
    -- Toggle by `I`
    -- git = {
    --     ignore = false,
    -- },

    -- Keeps cursor on the first letter of the filename when navigating tree
    hijack_cursor = true,

    view = {
        preserve_window_proportions = true,
    },

    renderer = {
        -- Enable highligting for folders and both file icons and names
        highlight_opened_files = "all",
        highlight_git = false,
        icons = {
            glyphs = {
                git = {
                    ignored = "",
                },
            },
        },
        indent_markers = {
            enable = true,
        },
    },
})
