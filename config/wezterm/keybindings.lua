local M = {}
local wezterm = require("wezterm")
local utils = require("utils")
local act = wezterm.action

local default = {
  -- Repeat leader to send it to terminal (as wezterm will swallow it otherwise)
  {
    key = "a",
    mods = "LEADER|CTRL",
    action = act.SendKey({ key = "a", mods = "CTRL" }),
  },

  -- Navigating
  { key = "Tab", mods = "CTRL", action = act.ActivateTabRelative(1) },
  { key = "Tab", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
  { key = "PageUp", mods = "ALT", action = act.ScrollByPage(-1) },
  { key = "PageDown", mods = "ALT", action = act.ScrollByPage(1) },

  -- Clear scrollback
  {
    key = "s",
    mods = "CTRL|SHIFT",
    action = act.ClearScrollback("ScrollbackOnly"),
  },

  -- Managing tabs/windows
  {
    key = "t",
    mods = "CTRL|SHIFT",
    action = act.SpawnTab("CurrentPaneDomain"),
  },

  -- Open debug overlay
  {
    key = "l",
    mods = "CTRL|ALT",
    action = act.ShowDebugOverlay,
  },

  -- Find/Select mode
  {
    key = "/",
    mods = "LEADER",
    action = act.Search({ CaseSensitiveString = "" }),
  },
  {
    key = "Space",
    mods = "CTRL|SHIFT",
    action = act.QuickSelect,
  },

  -- Copy/Paste
  { key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
  { key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
  { key = "[", mods = "LEADER", action = act.ActivateCopyMode },

  -- Font size
  { key = "0", mods = "CTRL", action = act.ResetFontSize },
  { key = "=", mods = "CTRL", action = act.IncreaseFontSize },
  { key = "-", mods = "CTRL", action = act.DecreaseFontSize },

  -- Pane Select
  {
    key = "s",
    mods = "LEADER",
    action = act.PaneSelect({
      mode = "SwapWithActive",
    }),
  },
}

local tmux = {
  -- Splitting
  {
    key = '"',
    mods = "LEADER|SHIFT",
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "-",
    mods = "LEADER",
    action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "%",
    mods = "LEADER|SHIFT",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "\\",
    mods = "LEADER",
    action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },

  {
    key = "x",
    mods = "LEADER",
    action = act.CloseCurrentPane({ confirm = true }),
  },

  -- Moving around
  {
    key = "h",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Left"),
  },
  {
    key = "l",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Right"),
  },
  {
    key = "k",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Up"),
  },

  {
    key = "j",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Down"),
  },

  {
    key = "LeftArrow",
    mods = "CTRL",
    action = act.EmitEvent("ActivatePaneDirection-left"),
  },
  {
    key = "RightArrow",
    mods = "CTRL",
    action = act.EmitEvent("ActivatePaneDirection-right"),
  },
  {
    key = "UpArrow",
    mods = "CTRL",
    action = act.EmitEvent("ActivatePaneDirection-up"),
  },
  {
    key = "DownArrow",
    mods = "CTRL",
    action = act.EmitEvent("ActivatePaneDirection-down"),
  },

  -- Use resize_pane table
  {
    key = "r",
    mods = "LEADER",
    action = act.ActivateKeyTable({
      name = "resize_pane",
      one_shot = false,
      replace_current = true,
    }),
  },
}

local resize_pane = {
  {
    key = "LeftArrow",
    mods = "ALT",
    action = act.AdjustPaneSize({ "Left", 1 }),
  },
  {
    key = "RightArrow",
    mods = "ALT",
    action = act.AdjustPaneSize({ "Right", 1 }),
  },
  {
    key = "UpArrow",
    mods = "ALT",
    action = act.AdjustPaneSize({ "Up", 1 }),
  },
  {
    key = "DownArrow",
    mods = "ALT",
    action = act.AdjustPaneSize({ "Down", 1 }),
  },

  -- Cancel the mode by pressing escape
  { key = "Escape", action = "PopKeyTable" },
}

-- Now construct base keybindings tables and export them
M.key_tables = {
  resize_pane = resize_pane,
}
M.keys = utils.table.join(default, tmux)

return M
