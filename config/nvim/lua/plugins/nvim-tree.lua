local icons = require("core.icons")
return {
  "kyazdani42/nvim-tree.lua",
  event = "VeryLazy",
  dependencies = { "nvim-web-devicons" },
  config = function()
    -- Mappings
    local nnoremap = require("core.utils").mapper_factory("n")

    nnoremap("<F1>", ":NvimTreeToggle<CR>", {
      desc = "Toggle NvimTree",
    })
    nnoremap("<Leader><F1>", ":NvimTreeFindFile<CR>", {
      desc = "Open current file tree in NvimTree",
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
    })
  end,
}
