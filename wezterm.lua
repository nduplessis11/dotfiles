-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = 'Gruvbox Dark (Gogh)'
config.automatically_reload_config = true
-- config.enable_tab_bar = false
config.window_close_confirmation = 'NeverPrompt'

config.font = wezterm.font('JetBrains Mono', { weight = 'Bold' })
config.font_size = 12.5

wezterm.on('update-right-status', function(window, pane)
  window:set_left_status(pane:get_domain_name() .. '[' .. window:mux_window():get_workspace() .. ']')
  window:set_right_status ''
end)

-- Tabs
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.show_tabs_in_tab_bar = true
config.show_new_tab_button_in_tab_bar = false
--config.switch_to_last_active_tab_when_closing_tab = true

config.leader = { key = 'a', mods = 'CTRL' }
config.keys = {
  { key = 'a', mods = 'LEADER|CTRL', action = wezterm.action { SendString = '\x01' } },
  { key = '-', mods = 'LEADER', action = wezterm.action { SplitVertical = { domain = 'CurrentPaneDomain' } } },
  { key = '\\', mods = 'LEADER', action = wezterm.action { SplitHorizontal = { domain = 'CurrentPaneDomain' } } },
  { key = 'o', mods = 'LEADER', action = 'TogglePaneZoomState' },
  { key = 'z', mods = 'LEADER', action = 'TogglePaneZoomState' },
  { key = 'c', mods = 'LEADER', action = wezterm.action { SpawnTab = 'CurrentPaneDomain' } },
  { key = 'h', mods = 'LEADER', action = wezterm.action { ActivatePaneDirection = 'Left' } },
  { key = 'j', mods = 'LEADER', action = wezterm.action { ActivatePaneDirection = 'Down' } },
  { key = 'k', mods = 'LEADER', action = wezterm.action { ActivatePaneDirection = 'Up' } },
  { key = 'l', mods = 'LEADER', action = wezterm.action { ActivatePaneDirection = 'Right' } },
  { key = 'H', mods = 'LEADER|SHIFT', action = wezterm.action { AdjustPaneSize = { 'Left', 5 } } },
  { key = 'J', mods = 'LEADER|SHIFT', action = wezterm.action { AdjustPaneSize = { 'Down', 5 } } },
  { key = 'K', mods = 'LEADER|SHIFT', action = wezterm.action { AdjustPaneSize = { 'Up', 5 } } },
  { key = 'L', mods = 'LEADER|SHIFT', action = wezterm.action { AdjustPaneSize = { 'Right', 5 } } },
  { key = '1', mods = 'LEADER', action = wezterm.action { ActivateTab = 0 } },
  { key = '2', mods = 'LEADER', action = wezterm.action { ActivateTab = 1 } },
  { key = '3', mods = 'LEADER', action = wezterm.action { ActivateTab = 2 } },
  { key = '4', mods = 'LEADER', action = wezterm.action { ActivateTab = 3 } },
  { key = '5', mods = 'LEADER', action = wezterm.action { ActivateTab = 4 } },
  { key = '6', mods = 'LEADER', action = wezterm.action { ActivateTab = 5 } },
  { key = '7', mods = 'LEADER', action = wezterm.action { ActivateTab = 6 } },
  { key = '8', mods = 'LEADER', action = wezterm.action { ActivateTab = 7 } },
  { key = '9', mods = 'LEADER', action = wezterm.action { ActivateTab = 8 } },
  { key = '&', mods = 'LEADER|SHIFT', action = wezterm.action { CloseCurrentTab = { confirm = true } } },
  { key = 'x', mods = 'LEADER', action = wezterm.action { CloseCurrentPane = { confirm = true } } },

  -- Attach to muxer
  {
    key = 'a',
    mods = 'LEADER',
    action = wezterm.action.AttachDomain 'unix',
  },

  -- Detach from muxer
  {
    key = 'd',
    mods = 'LEADER',
    action = wezterm.action.DetachDomain { DomainName = 'unix' },
  },

  {
    key = '$',
    mods = 'LEADER|SHIFT',
    action = wezterm.action.PromptInputLine {
      description = 'Enter new name for session',
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          wezterm.mux.rename_workspace(window:mux_window():get_workspace(), line)
        end
      end),
    },
  },

  -- Show list of workspaces
  {
    key = 's',
    mods = 'LEADER',
    action = wezterm.action.ShowLauncherArgs { flags = 'WORKSPACES' },
  },
}

config.unix_domains = {
  {
    name = 'unix',
  },
}

-- and finally, return the configuration to wezterm
return config

-- vim: ts=2 sts=2 sw=2 et
