---@type LazySpec
return {
  -- Blazingly fast movements
  "folke/flash.nvim",
  keys = {
    {
      "s",
      mode = { "n", "o" },
      function()
        require("flash").jump()
      end,
      desc = "Flash",
    },
    -- {
    --   "S",
    --   mode = { "n", "x", "o" },
    --   function()
    --     require("flash").treesitter()
    --   end,
    --   desc = "Flash Treesitter",
    -- },
    -- {
    --   "R",
    --   mode = { "o", "x" },
    --   function()
    --     require("flash").treesitter_search()
    --   end,
    --   desc = "Treesitter Search",
    -- },
    {
      "r",
      mode = "o",
      function()
        require("flash").remote()
      end,
      desc = "Remote Flash",
    },
    {
      "<c-s>",
      mode = { "c" },
      function()
        require("flash").toggle()
      end,
      desc = "Toggle Flash Search",
    },
  },
}
