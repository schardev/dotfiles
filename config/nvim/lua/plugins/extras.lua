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

  -- Session management
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    keys = {
      {
        "<leader>so",
        function()
          require("persistence").load()
        end,
        desc = "Load session for current directory",
      },
      {
        "<leader>sl",
        function()
          require("persistence").load({ last = true })
        end,
        desc = "Load last session",
      },
      {
        "<leader>sq",
        function()
          require("persistence").stop()
        end,
        desc = "Stop session",
      },
    },
    config = true,
  },
}
