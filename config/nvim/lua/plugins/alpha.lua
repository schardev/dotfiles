local icons = require("icons")
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
      local total_plugins =
        string.format("%s %s plugins", icons.devicons.download, stats.count)
      local ver = vim.version()
      local ver_info = string.format(
        "%s v%s.%s.%s",
        icons.diagnostics.info,
        ver.major,
        ver.minor,
        ver.patch
      )
      local startuptime = string.format(
        "%s %sms startup",
        icons.devicons.flash,
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
      dashboard.button(
        "n",
        string.format("%s  New file", icons.devicons.file),
        ":ene <BAR> startinsert <CR>"
      ),
      dashboard.button(
        "SPC f v",
        string.format("%s  Find File", icons.devicons.search)
      ),
      dashboard.button(
        "SPC f o",
        string.format("%s  Recent files", icons.devicons.files)
      ),
      dashboard.button(
        "<F1>",
        string.format("%s  NvimTree", icons.devicons.folder),
        ":NvimTreeToggle<CR>"
      ),
      dashboard.button(
        "pu",
        string.format("%s  Lazy Update", icons.devicons.update),
        "<Cmd>Lazy update<CR>"
      ),
      dashboard.button(
        "ps",
        string.format("%s  Lazy Show", icons.devicons.check),
        "<Cmd>Lazy show<CR>"
      ),
      dashboard.button(
        "pp",
        string.format("%s  Lazy Profile", icons.devicons.speedometer),
        "<Cmd>Lazy profile<CR>"
      ),
      dashboard.button(
        "ch",
        string.format("%s  Check Health", icons.devicons.plus_circle),
        "<Cmd>checkhealth<CR>"
      ),
      dashboard.button(
        "q",
        string.format("%s  Quit", icons.diagnostics.error),
        ":qa<CR>"
      ),
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
