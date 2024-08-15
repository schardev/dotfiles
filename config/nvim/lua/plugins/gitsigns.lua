return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  opts = {
    max_file_length = 5000,
    preview_config = { border = "rounded" },
    on_attach = function(bufnr)
      local gs = require("gitsigns")
      local nnoremap = require("core.utils").mapper_factory("n")
      local vnoremap = require("core.utils").mapper_factory("v")

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
      vnoremap("<leader>gs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, { desc = "Stage hunk" })
      nnoremap("<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
      nnoremap("<leader>gu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
      nnoremap("<leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
      nnoremap("<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
      nnoremap("<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
      nnoremap("<leader>gd", gs.diffthis, { desc = "Diffthis" })
      -- nnoremap("<leader>gD", function()
      --     gs.diffthis("~")
      -- end, { desc = "Diffthis" })
      nnoremap("<leader>gb", gs.blame_line, { desc = "Toggle line blame" })
    end,
  },
}
