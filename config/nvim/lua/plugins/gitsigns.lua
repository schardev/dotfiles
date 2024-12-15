return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  opts = {
    max_file_length = 5000,
    preview_config = { border = "rounded" },
    on_attach = function(bufnr)
      local gs = require("gitsigns")
      local map = require("core.utils").map

      -- Mappings
      map("n", "]c", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.nav_hunk("next")
        end)
        return "<Ignore>"
      end, { desc = "Go to next hunk", expr = true, buffer = bufnr })

      map("n", "[c", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.nav_hunk("prev")
        end)
        return "<Ignore>"
      end, { desc = "Go to prev hunk", expr = true, buffer = bufnr })

      map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
      map("v", "<leader>gs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Stage hunk")
      map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
      map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")
      map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
      map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")
      map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
      map("n", "<leader>gd", gs.diffthis, "Diffthis")
      -- map('n',"<leader>gD", function()
      --     gs.diffthis("~")
      -- end, { desc = "Diffthis" })
      map("n", "<leader>gb", gs.blame_line, "Toggle line blame")
    end,
  },
}
