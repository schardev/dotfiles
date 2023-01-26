return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    local function pick_color()
      math.randomseed(os.time())
      local colors = { "String", "Identifier", "Keyword", "Number" }
      return colors[math.random(#colors)]
    end

    local function footer()
      local stats = require("lazy").stats()
      local total_plugins = string.format(" %s plugins", stats.count)
      local ver = vim.version()
      local ver_info =
        string.format(" v%s.%s.%s", ver.major, ver.minor, ver.patch)
      local startuptime = string.format(
        " %sms startup",
        math.floor(stats.startuptime * 100) / 100
      )

      return string.format(
        "%s    %s    %s",
        startuptime,
        total_plugins,
        ver_info
      )
    end

    local logo = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
    }

    dashboard.section.header.val = logo
    dashboard.section.header.opts.hl = pick_color()
    dashboard.section.buttons.val = {
      dashboard.button("n", "  New file", ":ene <BAR> startinsert <CR>"),
      dashboard.button("SPC f v", "  Find File"),
      dashboard.button("SPC s r", "  Recent files"),
      dashboard.button("<F1>", "  NvimTree", ":NvimTreeToggle<CR>"),
      dashboard.button("pu", "  Lazy Update", "<Cmd>Lazy update<CR>"),
      dashboard.button("ps", "  Lazy Show", "<Cmd>Lazy show<CR>"),
      dashboard.button("pp", "󰞯  Lazy Profile", "<Cmd>Lazy profile<CR>"),
      dashboard.button("ch", "  Check Health", "<Cmd>checkhealth<CR>"),
      dashboard.button("q", "  Quit", ":qa<CR>"),
    }
    dashboard.section.footer.val = footer()
    dashboard.section.footer.opts.hl = "Constant"

    alpha.setup(dashboard.opts)

    vim.api.nvim_create_autocmd("User", {
      pattern = "LazyVimStarted",
      callback = function()
        dashboard.section.footer.val = footer()
        pcall(vim.cmd.AlphaRedraw)
      end,
    })
  end,
}
