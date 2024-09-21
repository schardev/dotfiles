---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  event = "BufEnter",
  dependencies = {
    "plenary.nvim",
    { "nvim-telescope/telescope-ui-select.nvim" },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
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
      "<Leader>fr",
      '"zy<ESC>:Telescope live_grep default_text=<c-r>z<CR>',
      { desc = "Live Grep visually selected text" }
    )
    nnoremap("<Leader>/", function()
      builtin.current_buffer_fuzzy_find(
        require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        })
      )
    end, { desc = "Fuzzy search current buffer" })
    nnoremap("<Leader>fe", builtin.resume, { desc = "Resume previous picker" })
    nnoremap("<Leader>fh", builtin.help_tags, { desc = "Helptags" })
    nnoremap("<Leader>ff", builtin.builtin, { desc = "Telescope Builtins" })
    nnoremap("<Leader>fo", builtin.oldfiles, { desc = "Oldfiles" })
    nnoremap("<Leader>fb", builtin.buffers, { desc = "Buffers List" })
    nnoremap("<Leader>fd", function()
      builtin.find_files({ cwd = "$DOTS_DIR" })
    end, { desc = "Find Files in $DOTS_DIR" })

    -- Telescope base config
    require("telescope").setup({
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })

    -- Load extensions if installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")
  end,
}
