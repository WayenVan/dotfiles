local wezterm = require("wezterm")
local config = wezterm.config_builder()

local is_linux = function()
  return wezterm.target_triple:find("linux") ~= nil
end

local is_darwin = function()
  return wezterm.target_triple:find("darwin") ~= nil
end

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.max_fps = 144

if is_darwin() then
  config.font_size = 16
elseif is_linux() then
else
  config.default_prog = { "powershell.exe" }
  config.font = wezterm.font("JetBrainsMono Nerd Font")
  config.font_size = 11
end

local date = os.date("*t")
if (tonumber(date.hour) >= 8) and (tonumber(date.hour) <= 19) then
  -- config.color_scheme = "Everforest Light Soft (Gogh)"
  config.color_scheme = "Catppuccin Latte"
else
  -- config.color_scheme = "Everforest Dark Soft (Gogh)"
  config.color_scheme = "Tokyo Night Moon"
  -- config.color_scheme = "Catppuccin Latte"
end

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

return config
