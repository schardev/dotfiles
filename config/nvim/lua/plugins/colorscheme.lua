---@type LazySpec
return {
  ---@module "catppuccin"
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    commit = "6d0d9ae",
    ---@type CatppuccinOptions
    opts = {
      no_italic = true,
      float = { solid = true, transparent = false },

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
        grug_far = true,
        leap = true,
        lsp_trouble = true,
        mason = true,
        neotest = true,
        nvim_surround = false,
        octo = true,
        snacks = { enabled = true },
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
