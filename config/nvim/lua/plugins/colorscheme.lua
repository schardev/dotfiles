return {
  {
    "folke/tokyonight.nvim",
    enabled = false,
    config = function()
      local g = vim.g
      g.tokyonight_style = "night"
      g.tokyonight_italic_keywords = false
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    commit = "3d0c37c",
    priority = 1000,
    opts = {
      no_italic = true,

      -- use lighter color for comments so that I can actually *see* them
      highlight_overrides = {
        mocha = function(colors)
          return {
            ["@comment"] = { fg = colors.overlay1 },
            VertSplit = { fg = colors.overlay1 },
          }
        end,
      },

      styles = {
        comments = { "italic" },
      },

      integrations = {
        lsp_trouble = true,
        leap = true,
        which_key = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd("colorscheme catppuccin")
    end,
  },
}
