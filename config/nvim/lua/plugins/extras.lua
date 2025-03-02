---@type LazySpec
return {

  -- Icons provider
  { "kyazdani42/nvim-web-devicons", lazy = true },

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

  -- Rainbow brackets
  {
    "HiPhish/rainbow-delimiters.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter" },
    config = function()
      vim.api.nvim_create_user_command("RainbowDelimitersToggle", function()
        require("rainbow-delimiters").toggle(0)
      end, { desc = "Toggle Rainbow Delimiters" })

      vim.g.rainbow_delimiters = {
        -- log = {
        --   level = vim.log.levels.TRACE,
        -- },
        blacklist = { "html", "lua", "json" },
      }
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
