local wezterm = require 'wezterm'
local act = wezterm.action
local wsl_domains = wezterm.default_wsl_domains()

wezterm.on("gui-startup", function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)

for _, domain in ipairs(wsl_domains) do
  domain.default_cwd = "~"
end

local function is_unix()
	return package.config:sub(1,1) == '/'
end

local shell = {"C:/Program Files/PowerShell/7/pwsh.exe", "-NoLogo"}
local font_name = "FiraCode NF"

if is_unix() then
  shell = { '/usr/local/bin/fish', '-l' }
end

if wezterm.target_triple == 'x86_64-apple-darwin' then
 font_name = "FiraCode Nerd Font"
end

if wezterm.target_triple == 'aarch64-apple-darwin' then
 font_name = "FiraCode Nerd Font"
end

return {
  adjust_window_size_when_changing_font_size = false,
  audible_bell = 'Disabled',
  background = {
    {
      source = { File = os.getenv("UserProfile") or os.getenv('HOME')  .. "/dotfiles/assets/background_0.png" },
       --opacity = 0.1
    },
    -- {
    --   source = { File = "C:\\Users\\johanw\\Pictures\\lapsimunitymodels\\LapSim5.png" },
    --    opacity = 0.1
    -- },
    -- {
    --   source = { File = "/Users/vlad/btsync/agilenet/nodes/common/WezTerm/backgrounds/devinsideyou/office-1080p.png" },
    --   horizontal_align = 'Center',
    --   vertical_align = 'Middle',
    --   height = 'Contain',
    --   width = 'Contain',
    --   repeat_x = 'NoRepeat',
    --   repeat_y = 'NoRepeat',
    --   opacity = 0.1
    -- },
  },
  color_scheme = 'One Dark (Gogh)',
  disable_default_key_bindings = true,
  exit_behavior = 'Close',
  font = wezterm.font {
    family = font_name,
    weight = 'Regular',
    stretch = 'Normal',
    style = 'Normal',
    harfbuzz_features = { 'cv29', 'cv30', 'ss01', 'ss03', 'ss06', 'ss07', 'ss09' },
  },
  font_size = 16,
  force_reverse_video_cursor = true,
  hide_mouse_cursor_when_typing = true,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom  = true,
  hide_tab_bar_if_only_one_tab = true,
  -- timeout_milliseconds defaults to 1000 and can be omitted
  -- for this example use `setxkbmap -option caps:none` in your terminal.
  leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1000 },
  mouse_bindings = {
    -- Scrolling up while holding CTRL increases the font size
    {
      event = { Down = { streak = 1, button = { WheelUp = 1 } } },
      mods = 'CTRL',
      action = act.IncreaseFontSize,
    },

    -- Scrolling down while holding CTRL decreases the font size
    {
      event = { Down = { streak = 1, button = { WheelDown = 1 } } },
      mods = 'CTRL',
      action = act.DecreaseFontSize,
    },
  },
  keys = {
    { action = wezterm.action.ActivateCommandPalette, mods = 'CTRL|SHIFT', key =     'P' },
    { action = wezterm.action.CopyTo    'Clipboard' , mods = 'CTRL|SHIFT', key =     'C' },
    { action = wezterm.action.DecreaseFontSize      , mods =       'CTRL', key =     '-' },
    { action = wezterm.action.IncreaseFontSize      , mods =       'CTRL', key =     '=' },
    { action = wezterm.action.Nop                   , mods =        'ALT', key = 'Enter' },
    { action = wezterm.action.PasteFrom 'Clipboard' , mods = 'CTRL|SHIFT', key =     'V' },
    { action = wezterm.action.ResetFontSize         , mods =       'CTRL', key =     '0' },
    { action = wezterm.action.ToggleFullScreen      ,                      key =   'F11' },

    { action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }        , mods =       'LEADER', key =     'h' },
    { action = wezterm.action.SplitVertical   { domain = 'CurrentPaneDomain' }        , mods =       'LEADER', key =     'v' },
  },
  scrollback_lines = 10000,
  show_update_window = true,
  use_dead_keys = false,
  unicode_version = 15,
  macos_window_background_blur = 100,
  window_close_confirmation = 'NeverPrompt',
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    --top = '0.6cell',
    bottom = 0,
  },
  wsl_domains = wsl_domains,
  default_prog = shell,
}
