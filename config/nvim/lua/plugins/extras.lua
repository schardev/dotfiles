return {

  -- Icons provider
  { "kyazdani42/nvim-web-devicons", lazy = "true" },

  -- library used by other plugins
  { "nvim-lua/plenary.nvim", lazy = true },

  -- Undo tree
  { "mbbill/undotree", cmd = "UndotreeToggle" },

  -- Git plugin
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull", "G" },
  },

  -- Surrounding stuff efficiently
  {
    "kylechui/nvim-surround",
    event = { "BufReadPost", "BufNewFile" },
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
        desc = "Search replace using treesitter",
      },
    },
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
