local icons = require("core.icons")

---@type LazySpec
return {
  "kyazdani42/nvim-tree.lua",
  dependencies = { "nvim-web-devicons" },
  keys = {
    { "<leader>tn", "<cmd>NvimTreeToggle<cr>", desc = "Toggle NvimTree" },
    {
      "<leader>nf",
      "<cmd>NvimTreeFindFileToggle<cr>",
      desc = "Open current file tree in NvimTree",
    },
  },
  opts = {
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
    -- hijack_cursor = true,

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
            untracked = icons.git.untracked,
          },
        },
      },
      indent_markers = {
        enable = true,
      },
    },
  },
}
