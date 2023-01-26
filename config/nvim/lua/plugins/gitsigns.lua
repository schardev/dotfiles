return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  opts = {
    max_file_length = 5000,
    on_attach = function(bufnr)
      local gs = require("gitsigns")
      local nnoremap = require("core.utils").mapper_factory("n")

      -- Mappings
      nnoremap("]c", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { desc = "Go to next hunk", expr = true, buffer = bufnr })

      nnoremap("[c", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { desc = "Go to prev hunk", expr = true, buffer = bufnr })

      nnoremap("<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
      nnoremap("<leader>gu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
      nnoremap("<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
      nnoremap("<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
      nnoremap("<leader>gd", gs.diffthis, { desc = "Diffthis" })
      -- nnoremap("<leader>gD", function()
      --     gs.diffthis("~")
      -- end, { desc = "Diffthis" })
      nnoremap(
        "<leader>gb",
        gs.toggle_current_line_blame,
        { desc = "Toggle line blame" }
      )
    end,
  },
}
