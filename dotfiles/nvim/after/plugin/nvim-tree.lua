local installed, _ = pcall(require, "nvim-tree")

if not installed then
    return
end

-- Enable highligting for folders and both file icons and names
vim.g.nvim_tree_highlight_opened_files = 3
vim.g.nvim_tree_git_hl = 1

-- Enable indent marker
vim.g.nvim_tree_indent_markers = 1

-- Icons
vim.g.nvim_tree_icons = {
    git = {
        ignored = "",
    },
}

-- Main setup
require("nvim-tree").setup {
    auto_close = true,
    disable_netrw = false,
    diagnostics = {
        enable = true,
    },

    actions = {
        open_file = {
            -- Auto-resize on opening file
            resize_window = "true",
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
}

-- Mappings
vim.api.nvim_set_keymap("n", "<F1>", ":NvimTreeToggle<CR>", {
    noremap = true,
    silent = true,
})

vim.api.nvim_set_keymap("n", "<Leader><F1>", ":NvimTreeFindFile<CR>", {
    noremap = true,
    silent = true,
})
