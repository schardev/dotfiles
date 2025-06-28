---@type LazySpec
return {
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull", "G" },
  },

  ---@module "diffview"
  {
    "sindrets/diffview.nvim",
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Diffview" },
    },
    ---@type DiffviewConfig
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      view = {
        default = {
          disable_diagnostics = true,
          winbar_info = true,
        },
      },
      file_panel = {
        listing_style = "list",
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    opts = {
      max_file_length = 5000,
      preview_config = { border = "rounded" },
      on_attach = function()
        local gs = require("gitsigns")
        local map = require("core.utils").map

        -- Mappings
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gs.nav_hunk("next")
          end
        end, "Go to next hunk")

        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gs.nav_hunk("prev")
          end
        end, "Go to prev hunk")

        map("n", "<leader>gs", gs.stage_hunk, "Stage / Unstage hunk")
        map("v", "<leader>gs", function()
          gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Stage hunk")

        map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
        map("v", "<leader>gr", function()
          gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, "Reset hunk")

        map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")
        map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>gb", gs.blame_line, "Toggle line blame")
      end,
    },
  },
}
