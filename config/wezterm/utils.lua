local wezterm = require("wezterm")
local colors = require("colors.catppuccin").colors
local M = { table = {} }

--- Adds the values from one array to the end of another and returns the result.
---@see https://github.com/premake/premake-core/
function M.table.join(...)
  local result = {}
  local arg = { ... }
  for _, t in ipairs(arg) do
    if type(t) == "table" then
      for _, v in ipairs(t) do
        table.insert(result, v)
      end
    else
      table.insert(result, t)
    end
  end
  return result
end

--- Function equivalent to basename in POSIX systems
function M.basename(str)
  if str then
    return string.gsub(str, "(.*/)(.*)", "%2")
  end
end

---Detect if running inside an editor or not
function M.is_editor(proc_name)
  local editors = { "nvim", "vim", "vi" }
  local name = M.basename(proc_name)
  for _, v in pairs(editors) do
    if name == v then
      return true
    end
  end
  return false
end

--- Get current process' nerdfont icon
--- (credits https://github.com/wez/wezterm/discussions/628#discussioncomment-4632891)
function M.get_process_icon(tab)
  local process_icons = {
    ["docker"] = {
      { Foreground = { Color = colors.blue } },
      { Text = wezterm.nerdfonts.linux_docker },
    },
    ["docker-compose"] = {
      { Foreground = { Color = colors.blue } },
      { Text = wezterm.nerdfonts.linux_docker },
    },
    ["nvim"] = {
      { Foreground = { Color = colors.green } },
      { Text = wezterm.nerdfonts.custom_vim },
    },
    ["vim"] = {
      { Foreground = { Color = colors.green } },
      { Text = wezterm.nerdfonts.dev_vim },
    },
    ["node"] = {
      { Foreground = { Color = colors.green } },
      { Text = wezterm.nerdfonts.mdi_nodejs },
    },
    ["zsh"] = {
      { Foreground = { Color = colors.peach } },
      { Text = wezterm.nerdfonts.dev_terminal },
    },
    ["bash"] = {
      { Foreground = { Color = colors.subtext0 } },
      { Text = wezterm.nerdfonts.cod_terminal_bash },
    },
    ["paru"] = {
      { Foreground = { Color = colors.lavender } },
      { Text = wezterm.nerdfonts.linux_archlinux },
    },
    ["htop"] = {
      { Foreground = { Color = colors.yellow } },
      { Text = wezterm.nerdfonts.mdi_chart_donut_variant },
    },
    ["cargo"] = {
      { Foreground = { Color = colors.peach } },
      { Text = wezterm.nerdfonts.dev_rust },
    },
    ["git"] = {
      { Foreground = { Color = colors.peach } },
      { Text = wezterm.nerdfonts.dev_git },
    },
    ["lua"] = {
      { Foreground = { Color = colors.blue } },
      { Text = wezterm.nerdfonts.seti_lua },
    },
    ["wget"] = {
      { Foreground = { Color = colors.yellow } },
      { Text = wezterm.nerdfonts.mdi_arrow_down_box },
    },
    ["curl"] = {
      { Foreground = { Color = colors.yellow } },
      { Text = wezterm.nerdfonts.mdi_flattr },
    },
    ["gh"] = {
      { Foreground = { Color = colors.mauve } },
      { Text = wezterm.nerdfonts.dev_github_badge },
    },
  }
  local process_name = M.basename(tab.active_pane.foreground_process_name)
  return wezterm.format(process_icons[process_name] or {
    { Foreground = { Color = colors.sky } },
    { Text = string.format("[%s]", process_name) },
  })
end

function M.get_current_working_dir(tab)
  local current_dir = tab.active_pane.current_working_dir
  local hostname = tab.active_pane.user_vars.WEZTERM_HOST
  local HOME_DIR = string.format("file://%s%s/", hostname, os.getenv("HOME"))

  return current_dir == HOME_DIR and " ~"
    or string.format(" %s", string.gsub(current_dir, "(.*/)(.*)/", "%2"))
end

function M.conditional_activate_pane(window, pane, wezterm_direction)
  if M.is_editor(pane:get_foreground_process_name()) then
    window:perform_action(
      wezterm.action.SendKey({
        key = wezterm_direction .. "Arrow",
        mods = "CTRL",
      }),
      pane
    )
  else
    -- FIXME: workaround edge case where wezterm swallows the keybinds
    -- when there's no pane exists in the given direction
    -- https://github.com/wez/wezterm/discussions/2990#discussioncomment-5095593
    window:perform_action(
      wezterm.action.ActivatePaneDirection(wezterm_direction),
      pane
    )
  end
end

return M
