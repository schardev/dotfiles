return {
  ---@module "catppuccin"
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    ---@type CatppuccinOptions
    opts = {
      no_italic = true,

      -- use lighter color for comments so that I can actually *see* them
      highlight_overrides = {
        mocha = function(colors)
          return {
            WinSeparator = { fg = colors.overlay1 },
            Folded = { bg = colors.surface0 },
          }
        end,
      },

      integrations = {
        diffview = true,
        fidget = true,
        leap = true,
        lsp_trouble = true,
        mason = true,
        neotest = true,
        telescope = { enabled = true, style = "nvchad" },
        which_key = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd("colorscheme catppuccin")
    end,
  },
}
