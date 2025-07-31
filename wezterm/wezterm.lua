local wezterm = require 'wezterm'
local launch_menu = {}
local config = wezterm.config_builder()

config.color_scheme = 'Gruvbox Material (Gogh)'
config.font = wezterm.font 'Hack Nerd Font'
config.font_size = 12.5

config.enable_tab_bar = false
-- config.tab_bar_at_bottom = true
-- config.use_fancy_tab_bar = false
-- config.show_tabs_in_tab_bar = true
-- config.show_new_tab_button_in_tab_bar = false

-- config.colors = {
--   tab_bar = {
--     active_tab = {
--       fg_color = 'black',
--       bg_color = 'green'
--     }
--   }
-- }


config.default_domain = 'WSL:Ubuntu'

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  table.insert(launch_menu, {
    label = 'PowerShell',
    args = { 'powershell.exe', '-NoLogo' },
  })

  -- Find installed visual studio version(s) and add their compilation
  -- environment command prompts to the menu
  for _, vsvers in
    ipairs(
      wezterm.glob('Microsoft Visual Studio/20*', 'C:/Program Files (x86)')
    )
  do
    local year = vsvers:gsub('Microsoft Visual Studio/', '')
    table.insert(launch_menu, {
      label = 'x64 Native Tools VS ' .. year,
      args = {
        'cmd.exe',
        '/k',
        'C:/Program Files (x86)/'
          .. vsvers
          .. '/BuildTools/VC/Auxiliary/Build/vcvars64.bat',
      },
    })
  end
end

config.launch_menu = launch_menu

return config
