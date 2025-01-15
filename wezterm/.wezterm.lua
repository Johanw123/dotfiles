local wezterm = require("wezterm")
local act = wezterm.action
local wsl_domains = wezterm.default_wsl_domains()

local background_color = "#22262e"

wezterm.on("gui-startup", function(cmd)
	local _, _, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():toggle_fullscreen()
end)

for _, domain in ipairs(wsl_domains) do
	domain.default_cwd = "~"
end

local function is_unix()
	return package.config:sub(1, 1) == "/"
end

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
local function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

local shell = { "C:/Program Files/PowerShell/7/pwsh.exe", "-NoLogo" }
local font_name = "FiraCode Nerd Font Mono"

-- The filled in variant of the < symbol
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local SOFT_LEFT_ARROW = wezterm.nerdfonts.pl_left_soft_divider

-- The filled in variant of the > symbol
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider
local SOFT_RIGHT_ARROW = wezterm.nerdfonts.pl_right_soft_divider

local SOLID_RIGHT_ARROW = utf8.char(0xe0b0)

if is_unix() then
	shell = { "/usr/local/bin/fish", "-l" }
end

if wezterm.target_triple == "x86_64-apple-darwin" then
	font_name = "FiraCode Nerd Font"
	shell = { "/opt/homebrew/bin/fish", "-l" }
end

if wezterm.target_triple == "aarch64-apple-darwin" then
	font_name = "FiraCode Nerd Font"
	shell = { "/opt/homebrew/bin/fish", "-l" }
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = "#2b2042"
	local foreground = "#909090"
	local index_foreground = "#909090"

	if tab.is_active then
		foreground = "white"
		index_foreground = "#D3A588"
	end

	local colors = {
		"#3c1361",
		"#3c1361",
		"#52307c",
		"#663a82",
		"#7c5295",
	}

	background = colors[tab.tab_index + 2]

	local index = " (" .. tab.tab_index + 1 .. ") "
	local title = tab_title(tab) .. " "

	--TODO: reduce title to tab_max_width - 1 for fitting the ending arrow on last tab

	local rtn = {
		{ Background = { Color = background } },
		{ Foreground = { Color = colors[tab.tab_index + 1] } },
		{ Text = SOLID_RIGHT_ARROW },
		{ Attribute = { Intensity = tab.is_active and "Bold" or "Normal" } },
		{ Background = { Color = background } },
		{ Foreground = { Color = index_foreground } },
		{ Text = index },
		{ Attribute = { Intensity = tab.is_active and "Bold" or "Normal" } },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
	}

	if tab.tab_index == #tabs - 1 then
		table.insert(rtn, { Background = { Color = background_color } })
		table.insert(rtn, { Foreground = { Color = background } })
		table.insert(rtn, { Text = SOLID_RIGHT_ARROW })
	end

	return rtn
end)

wezterm.on("update-right-status", function(window, pane)
	-- Each element holds the text for a cell in a "powerline" style << fade
	local cells = {}

	-- Figure out the cwd and host of the current pane.
	-- This will pick up the hostname for the remote host if your
	-- shell is using OSC 7 on the remote host.
	local cwd_uri = pane:get_current_working_dir().file_path
	if cwd_uri then
		cwd_uri = cwd_uri:sub(8)
		local slash = cwd_uri:find("/")
		local cwd = ""
		local hostname = ""
		if slash then
			hostname = cwd_uri:sub(1, slash - 1)
			-- Remove the domain name portion of the hostname
			local dot = hostname:find("[.]")
			if dot then
				hostname = hostname:sub(1, dot - 1)
			end
			-- and extract the cwd from the uri
			cwd = cwd_uri:sub(slash)

			table.insert(cells, cwd)
			table.insert(cells, hostname)
		end
	end

	-- I like my date/time in this style: "Wed Mar 3 08:14"
	local date = wezterm.strftime("%a %b %-d %H:%M")
	table.insert(cells, date)

	-- An entry for each battery (typically 0 or 1 battery)
	for _, b in ipairs(wezterm.battery_info()) do
		table.insert(cells, string.format("%.0f%%", b.state_of_charge * 100))
	end

	-- The powerline < symbol
	local LEFT_ARROW = utf8.char(0xe0b3)
	-- The filled in variant of the < symbol
	local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

	-- Color palette for the backgrounds of each cell
	local colors = {
		"#3c1361",
		"#52307c",
		"#663a82",
		"#7c5295",
	}

	-- Foreground color for the text across the fade
	local text_fg = "#c0c0c0"

	-- The elements to be formatted
	local elements = {}
	-- How many cells have been formatted
	local num_cells = 0

	-- Translate a cell into elements
	local function push(text, is_last, is_first)
		local cell_no = num_cells + 1

		if is_first then
			table.insert(elements, { Background = { Color = background_color } })
			table.insert(elements, { Foreground = { Color = colors[cell_no] } })
			table.insert(elements, { Text = SOLID_LEFT_ARROW })
		end

		table.insert(elements, { Foreground = { Color = text_fg } })
		table.insert(elements, { Background = { Color = colors[cell_no] } })
		table.insert(elements, { Text = " " .. text .. " " })

		if not is_last then
			table.insert(elements, { Foreground = { Color = colors[cell_no + 1] } })
			table.insert(elements, { Text = SOLID_LEFT_ARROW })
		end

		num_cells = num_cells + 1
	end

	while #cells > 0 do
		local cell = table.remove(cells, 1)
		push(cell, #cells == 0, #elements == 0)
	end

	window:set_right_status(wezterm.format(elements))
end)

local config = {
	adjust_window_size_when_changing_font_size = false,
	audible_bell = "Disabled",
	background = {
		{
			source = { File = os.getenv("UserProfile") or os.getenv("HOME") .. "/dotfiles/assets/background_0.png" },
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
	color_scheme = "One Dark (Gogh)",
	disable_default_key_bindings = true,
	exit_behavior = "Close",
	font = wezterm.font({
		family = font_name,
		weight = "Regular",
		stretch = "Normal",
		style = "Normal",
		harfbuzz_features = { "cv29", "cv30", "ss01", "ss03", "ss06", "ss07", "ss09" },
	}),
	colors = {
		tab_bar = {
			-- The color of the strip that goes along the top of the window
			-- (does not apply when fancy tab bar is in use)
			-- background = '#1e222a',
			background = background_color,
		},
	},
	font_size = 16,
	tab_max_width = 30,
	max_fps = 240,
	animation_fps = 30,
	force_reverse_video_cursor = true,
	hide_mouse_cursor_when_typing = true,
	use_fancy_tab_bar = false,
	tab_bar_at_bottom = false,
	show_new_tab_button_in_tab_bar = false,
	hide_tab_bar_if_only_one_tab = false,
	-- timeout_milliseconds defaults to 1000 and can be omitted
	-- for this example use `setxkbmap -option caps:none` in your terminal.
	leader = { key = "b", mods = "CTRL", timeout_milliseconds = 1000 },
	mouse_bindings = {
		-- Scrolling up while holding CTRL increases the font size
		{
			event = { Down = { streak = 1, button = { WheelUp = 1 } } },
			mods = "CTRL",
			action = act.IncreaseFontSize,
		},

		-- Scrolling down while holding CTRL decreases the font size
		{
			event = { Down = { streak = 1, button = { WheelDown = 1 } } },
			mods = "CTRL",
			action = act.DecreaseFontSize,
		},
	},
	keys = {
		{ action = wezterm.action.ActivateCommandPalette, mods = "CTRL|SHIFT", key = "P" },
		{ action = wezterm.action.CopyTo("Clipboard"), mods = "CTRL|SHIFT", key = "C" },
		{ action = wezterm.action.DecreaseFontSize, mods = "CTRL", key = "-" },
		{ action = wezterm.action.IncreaseFontSize, mods = "CTRL", key = "=" },
		{ action = wezterm.action.Nop, mods = "ALT", key = "Enter" },
		{ action = wezterm.action.PasteFrom("Clipboard"), mods = "CTRL|SHIFT", key = "V" },
		{ action = wezterm.action.ResetFontSize, mods = "CTRL", key = "0" },
		{ action = wezterm.action.ToggleFullScreen, key = "F11" },

		{
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
			mods = "LEADER",
			key = "h",
		},
		{
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
			mods = "LEADER",
			key = "v",
		},

		{
			action = wezterm.action.CloseCurrentTab({ confirm = true }),
			mods = "LEADER",
			key = "x",
		},
		{ action = act.SpawnTab("CurrentPaneDomain"), mods = "LEADER", key = "n" },

		{
			key = "r",
			mods = "LEADER",
			action = act.PromptInputLine({
				description = "Enter new name for tab",
				action = wezterm.action_callback(function(window, pane, line)
					-- line will be `nil` if they hit escape without entering anything
					-- An empty string if they just hit enter
					-- Or the actual line of text they wrote
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},

		{ -- Allows Ctrl-Space keybindings in neovim
			key = " ",
			mods = "CTRL",
			action = act.SendKey({
				key = " ",
				mods = "CTRL",
			}),
		},
	},
	line_height = 1.0,
	scrollback_lines = 10000,
	status_update_interval = 100,
	show_update_window = true,
	use_dead_keys = false,
	unicode_version = 15,
	macos_window_background_blur = 100,
	window_close_confirmation = "NeverPrompt",
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

for i = 1, 8 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

return config
