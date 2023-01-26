return {
  -- Improve startup time for Neovim
  "lewis6991/impatient.nvim",

  -- Icons provider
  { "kyazdani42/nvim-web-devicons", lazy = "true" },

  -- Shows human friendly startuptime
  { "dstein64/vim-startuptime", cmd = "StartupTime" },

  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },

  -- Undo tree
  { "mbbill/undotree", cmd = "UndotreeToggle" },

  -- Workspace diagnostics
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = {
      use_diagnostic_signs = true,
    },
  },

  -- Git plugin
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
  },

  -- Surrounding stuff efficiently
  {
    "kylechui/nvim-surround",
    event = "BufReadPost",
    config = true,
  },

  -- Blazingly fast movements
  {
    "ggandor/leap.nvim",
    event = "VeryLazy",
    config = function()
      require("leap").set_default_keymaps()
    end,
  },

  -- Treesitter powered search and replace
  {
    "cshuaimin/ssr.nvim",
    keys = {
      {
        "<leader>tr",
        function()
          require("ssr").open()
        end,
        mode = { "n", "v" },
      },
    },
  },

  -- A plugin to ... umm ... comment stuff
  {
    "numToStr/Comment.nvim",
    keys = {
      "gcc",
      "gbc",
      { "gc", mode = "v" },
      { "gbc", mode = "v" },
    },
    config = function()
      require("Comment").setup({
        pre_hook = require(
          "ts_context_commentstring.integrations.comment_nvim"
        ).create_pre_hook(),
      })
    end,
  },

  -- Autopairs for bracket completions
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
    },
  },
}
