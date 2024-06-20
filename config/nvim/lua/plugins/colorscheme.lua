return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      no_italic = true,

      -- use lighter color for comments so that I can actually *see* them
      highlight_overrides = {
        mocha = function(colors)
          return {
            ["@comment"] = { fg = colors.overlay1 },
            VertSplit = { fg = colors.overlay1 },
            WinSeparator = { fg = colors.overlay1 },
          }
        end,
      },

      integrations = {
        fidget = true,
        leap = true,
        lsp_trouble = true,
        mason = true,
        which_key = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd("colorscheme catppuccin")
    end,
  },
}
