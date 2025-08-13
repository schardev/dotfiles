---@type LazySpec
return {
  {
    ---@module "snacks"
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true, size = 1024 * 500 },
      dashboard = { enabled = true },
      quickfile = { enabled = true },
      terminal = { start_insert = true, auto_insert = false },
      statuscolumn = {
        enabled = false,
        left = { "sign", "git", "mark" },
        right = {},
      },
    },
  -- stylua: ignore
    keys = {
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete buffer" },
      { "<leader>bo", function() Snacks.bufdelete.other() end, desc = "Delete all other buffers" },
      { "<leader>gBb", function() Snacks.gitbrowse({what = "branch"}) end, desc = "Git browse branch", mode = { "n", "v" } },
      { "<leader>gBf", function() Snacks.gitbrowse({what = "file"}) end, desc = "Git browse file", mode = { "n", "v" } },
      { "<leader>gBp", function() Snacks.gitbrowse({what = "permalink"}) end, desc = "Git open permalink", mode = { "n", "v" } },
      { "<leader>gBr", function() Snacks.gitbrowse({what = "repo"}) end, desc = "Git browse repo", mode = { "n", "v" } },
      { "<c-`>", function() Snacks.terminal() end, desc = "Toggle Terminal", mode = {'n', 't'} },
    },
  },
}
