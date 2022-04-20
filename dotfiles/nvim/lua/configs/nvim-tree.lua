-- Enable highligting for folders and both file icons and names
vim.g.nvim_tree_highlight_opened_files = 3
vim.g.nvim_tree_git_hl = 1

-- Icons
vim.g.nvim_tree_icons = {
    git = {
        ignored = "",
    },
}

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
        indent_markers = {
            enable = true,
        },
    },
})

-- Mappings
local nnoremap = require("utils").nnoremap
nnoremap("<F1>", ":NvimTreeToggle<CR>", {
    desc = "Toggle NvimTree",
})
nnoremap("<Leader><F1>", ":NvimTreeFindFile<CR>", {
    desc = "Open current file tree in NvimTree",
})
