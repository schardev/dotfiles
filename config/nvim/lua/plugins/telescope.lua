return {
  "nvim-telescope/telescope.nvim",
  event = "BufEnter",
  dependencies = {
    "plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  config = function()
    local nnoremap = require("core.utils").mapper_factory("n")
    local vnoremap = require("core.utils").mapper_factory("v")
    local builtin = require("telescope.builtin")

    -- Mappings
    nnoremap("<Leader>fv", builtin.find_files, { desc = "Find Files" })
    nnoremap("<Leader>fV", function()
      builtin.find_files({ hidden = true, no_ignore = true })
    end, { desc = "Find Files (incl. hidden and ignored)" })
    nnoremap("<Leader>fr", builtin.live_grep, { desc = "Live Grep" })
    vnoremap(
      "<Leader>fg",
      '"zy<ESC>:Telescope live_grep default_text=<c-r>z<CR>',
      { desc = "Live Grep visually selected text" }
    )
    nnoremap("<Leader>fe", builtin.resume, { desc = "Resume previous picker" })
    nnoremap("<Leader>fh", builtin.help_tags, { desc = "Helptags" })
    nnoremap("<Leader>ff", builtin.builtin, { desc = "Telescope Builtins" })
    nnoremap("<Leader>fo", builtin.oldfiles, { desc = "Oldfiles" })
    nnoremap("<Leader>fb", builtin.buffers, { desc = "Buffers List" })
    nnoremap("<Leader>fd", function()
      builtin.find_files({ cwd = "$DOTS_DIR" })
    end, { desc = "Find Files in $DOTS_DIR" })

    -- Telescope base config
    require("telescope").setup({})

    -- Load native fzf sorter
    require("telescope").load_extension("fzf")
  end,
}
