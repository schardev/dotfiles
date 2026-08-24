---@type LazySpec
return {
  ---@module "catppuccin"
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    -- commit = "6d0d9ae",
    ---@type CatppuccinOptions
    opts = {
      no_italic = true,
      float = { solid = true, transparent = false },

      highlight_overrides = {
        mocha = function(colors)
          return {
            WinSeparator = { fg = colors.overlay1 },
            Folded = { bg = colors.surface0 },
            -- FloatBorder = { fg = colors.overlay1 },
          }
        end,
      },

      auto_integrations = true,
      integrations = {
        nvim_surround = false,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd("colorscheme catppuccin-nvim")
    end,
  },
}
