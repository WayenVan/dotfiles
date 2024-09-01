local wezterm = require("wezterm")
local config = wezterm.config_builder()

local is_linux = function()
	return wezterm.target_triple:find("linux") ~= nil
end

local is_darwin = function()
	return wezterm.target_triple:find("darwin") ~= nil
end

-- config for multiplexer

local ssh_domains = {
	{
		name = "main.mec",
		remote_address = "10.192.31.3",
		username = "jingyan",
	},
}

config.ssh_domains = ssh_domains

-- fong
config.font = wezterm.font("JetBrainsMono Nerd Font")
config.max_fps = 144

if is_darwin() then
	config.font_size = 16
elseif is_linux() then
else
	config.default_prog = { "powershell.exe" }
	config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Medium" })
	config.font_size = 11
end

-- color scheme
local date = os.date("*t")
if (tonumber(date.hour) >= 8) and (tonumber(date.hour) <= 19) then
	-- config.color_scheme = "Everforest Light Soft (Gogh)"
	config.color_scheme = "Catppuccin Latte"
else
	-- config.color_scheme = "Everforest Dark Soft (Gogh)"
	config.color_scheme = "Tokyo Night Moon"
	-- config.color_scheme = "Catppuccin Latte"
end

-- window layout
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.enable_tab_bar = true
-- config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = true
config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
config.adjust_window_size_when_changing_font_size = false

config.underline_position = "-4"

-- opacity
config.window_background_opacity = 0.95
-- keymap
config.leader = { key = "Space", mods = "SHIFT" }
config.keys = {
	{
		key = "v",
		mods = "LEADER",
		action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	},
	{
		key = "s",
		mods = "LEADER",
		action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
	},
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action({ ActivatePaneDirection = "Left" }),
	},
	{
		key = "j",
		mods = "LEADER",
		action = wezterm.action({ ActivatePaneDirection = "Down" }),
	},
	{
		key = "k",
		mods = "LEADER",
		action = wezterm.action({ ActivatePaneDirection = "Up" }),
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action({ ActivatePaneDirection = "Right" }),
	},
	-- panel sizing
	{
		key = "LeftArrow",
		mods = "CTRL | SHIFT",
		action = wezterm.action({ AdjustPaneSize = { "Left", 1 } }),
	},
	{
		key = "UpArrow",
		mods = "CTRL | SHIFT",
		action = wezterm.action({ AdjustPaneSize = { "Up", 1 } }),
	},
	{
		key = "DownArrow",
		mods = "CTRL | SHIFT",
		action = wezterm.action({ AdjustPaneSize = { "Down", 1 } }),
	},
	{
		key = "RightArrow",
		mods = "CTRL | SHIFT",
		action = wezterm.action({ AdjustPaneSize = { "Right", 1 } }),
	},
	-- mat tab switching
	{
		key = "1",
		mods = "LEADER",
		action = wezterm.action({
			ActivateTab = 0,
		}),
	},
	{
		key = "2",
		mods = "LEADER",
		action = wezterm.action({
			ActivateTab = 1,
		}),
	},
	{
		key = "3",
		mods = "LEADER",
		action = wezterm.action({
			ActivateTab = 2,
		}),
	},
	{
		key = "4",
		mods = "LEADER",
		action = wezterm.action({
			ActivateTab = 3,
		}),
	},
	{
		key = "5",
		mods = "LEADER",
		action = wezterm.action({
			ActivateTab = 4,
		}),
	},
	{
		key = "6",
		mods = "LEADER",
		action = wezterm.action({
			ActivateTab = 5,
		}),
	},
	{
		key = "7",
		mods = "LEADER",
		action = wezterm.action({
			ActivateTab = 6,
		}),
	},
	{
		key = "8",
		mods = "LEADER",
		action = wezterm.action({
			ActivateTab = 7,
		}),
	},
	{
		key = "9",
		mods = "LEADER",
		action = wezterm.action({
			ActivateTab = -1,
		}),
	},
	{
		key = "q",
		mods = "LEADER",
		action = wezterm.action({
			CloseCurrentTab = {
				confirm = true,
			},
		}),
	},
	{
		key = "[",
		mods = "LEADER",
		action = wezterm.action({
			ActivateTabRelative = -1,
		}),
	},
	{
		key = "]",
		mods = "LEADER",
		action = wezterm.action({
			ActivateTabRelative = 1,
		}),
	},
}

return config
