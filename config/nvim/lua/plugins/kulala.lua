---@type LazySpec
return {
  "mistweaverco/kulala.nvim",
  ft = { "http", "rest" },
  submodules = false,
  keys = {
    { mode = { "n", "v" }, "<leader>Rs", desc = "Send request" },
    { mode = { "n", "v" }, "<leader>Ra", desc = "Send all requests" },
    { "<leader>Rb", desc = "Open scratchpad" },
  },
  opts = {
    global_keymaps = true,
    global_keymaps_prefix = "<leader>R",
    kulala_keymaps_prefix = "<localleader>",
    request_timeout = 10000,
    ui = {
      split_direction = "horizontal",
      scratchpad_default_contents = {
        "GET https://httpbin.org/get HTTP/1.1",
        "Accept: application/json",
        "Content-Type: application/json",
      },
    },
    kulala_keymaps = {
      ["Show headers"] = {
        "<localleader>h",
        function()
          require("kulala.ui").show_headers()
        end,
      },
      ["Show body"] = {
        "<localleader>b",
        function()
          require("kulala.ui").show_body()
        end,
      },
      ["Show headers and body"] = {
        "<localleader>a",
        function()
          require("kulala.ui").show_headers_body()
        end,
      },
      ["Show verbose"] = {
        "<localleader>v",
        function()
          require("kulala.ui").show_verbose()
        end,
      },
      ["Show script output"] = {
        "<localleader>o",
        function()
          require("kulala.ui").show_script_output()
        end,
      },
      ["Show stats"] = {
        "<localleader>s",
        function()
          require("kulala.ui").show_stats()
        end,
      },
      ["Show report"] = {
        "<localleader>r",
        function()
          require("kulala.ui").show_report()
        end,
      },
    },
  },
}
