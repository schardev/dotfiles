local M = {}
local wezterm = require("wezterm")
local utils = require("utils")
local colors = require("colors.catppuccin").colors

M.setup = function()
  -- `update-status` is emitted based on the interval specified by the
  -- `status_update_interval` configuration value (default 1000)
  wezterm.on("update-status", function(window)
    -- Show which key table is active in the status area
    -- Also show when leader is active
    local name = window:active_key_table()
    if name then
      name = wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { Color = colors.mantle } },
        { Background = { Color = colors.peach } },
        {
          Text = string.upper(" " .. string.gsub(name, "_", " ")) .. " ",
        },
      })
    elseif window:leader_is_active() then
      name = wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { Color = colors.mantle } },
        { Background = { Color = colors.blue } },
        { Text = " LEADER " },
      })
    end
    window:set_right_status(name or "")
  end)

  -- Tab title
  wezterm.on("format-tab-title", function(tab)
    return wezterm.format({
      { Attribute = { Intensity = "Bold" } },
      { Text = string.format(" %s ", tab.tab_index + 1) },
      "ResetAttributes",
      { Text = utils.get_process_icon(tab) },
      { Text = utils.get_current_working_dir(tab) },
      { Foreground = { Color = colors.base } },
      { Text = "  ▕" },
    })
  end)

  -- Pane navigation
  wezterm.on("ActivatePaneDirection-right", function(window, pane)
    utils.conditional_activate_pane(window, pane, "Right")
  end)
  wezterm.on("ActivatePaneDirection-left", function(window, pane)
    utils.conditional_activate_pane(window, pane, "Left")
  end)
  wezterm.on("ActivatePaneDirection-up", function(window, pane)
    utils.conditional_activate_pane(window, pane, "Up")
  end)
  wezterm.on("ActivatePaneDirection-down", function(window, pane)
    utils.conditional_activate_pane(window, pane, "Down")
  end)
end

return M
