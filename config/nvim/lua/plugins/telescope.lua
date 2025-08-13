---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  event = { "VeryLazy" },
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
    local map = require("core.utils").map
    local builtin = require("telescope.builtin")

    -- Mappings
    map("n", "<Leader>fv", builtin.find_files, "Find Files")
    map("n", "<Leader>fV", function()
      builtin.find_files({ hidden = true, no_ignore = true })
    end, "Find Files (incl. hidden and ignored)")
    map("n", "<Leader>fr", builtin.live_grep, "Live Grep")
    map(
      "v",
      "<Leader>fr",
      '"zy<ESC>:Telescope live_grep default_text=<c-r>z<CR>',
      "Live Grep visually selected text"
    )
    map("n", "<Leader>/", function()
      builtin.current_buffer_fuzzy_find(
        require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        })
      )
    end, "Fuzzy search current buffer")
    map("n", "<Leader>fe", builtin.resume, "Resume previous picker")
    map("n", "<Leader>fh", builtin.help_tags, "Helptags")
    map("n", "<Leader>ff", builtin.builtin, "Telescope Builtins")
    map("n", "<Leader>fo", builtin.oldfiles, "Oldfiles")
    map("n", "<Leader>fb", builtin.buffers, "Buffers List")
    map("n", "<Leader>fd", function()
      builtin.find_files({ cwd = "$DOTS_DIR" })
    end, "Find Files in $DOTS_DIR")
    map("n", "<Leader>fR", function()
      builtin.find_files({ cwd = "~/dev/http-requests", default_text = "http$" })
    end, "Find request files in ~/dev/http-requests")

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
