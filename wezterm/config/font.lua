---@diagnostic disable: undefined-field

local wt = require "wezterm"
local fs = require("utils.fn").fs

local Config = {}

Config.adjust_window_size_when_changing_font_size = false
Config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"
-- Config.anti_alias_custom_block_glyphs = true

Config.font = wt.font_with_fallback {
  {
    family = "Maple Mono NF CN",
    weight = "Regular",
    harfbuzz_features = {
      -- "cv01", ---styles: a
      -- "cv02", ---styles: g
      "cv06", ---styles: i (03..06)
      -- "cv09", ---styles: l (07..10)
      "cv12", ---styles: 0 (11..13, zero)
      "cv14", ---styles: 3
      "cv16", ---styles: * (15..16)
      -- "cv17", ---styles: ~
      -- "cv18", ---styles: %
      -- "cv19", ---styles: <= (19..20)
      -- "cv21", ---styles: =< (21..22)
      -- "cv23", ---styles: >=
      -- "cv24", ---styles: /=
      "cv25", ---styles: .-
      "cv26", ---styles: :-
      -- "cv27", ---styles: []
      "cv28", ---styles: {. .}
      "cv29", ---styles: { }
      -- "cv30", ---styles: |
      "cv31", ---styles: ()
      "cv32", ---styles: .=
      -- "ss01", ---styles: r
      -- "ss02", ---styles: <= >=
      "ss03", ---styles: &
      "ss04", ---styles: $
      "ss05", ---styles: @
      -- "ss06", ---styles: \\
      "ss07", ---styles: =~ !~
      -- "ss08", ---styles: == === != !==
      "ss09", ---styles: >>= <<= ||= |=
      -- "ss10", ---styles: Fl Tl fi fj fl ft
      -- "onum", ---styles: 1234567890
    },
  },
  { family = "Noto Color Emoji" },
  { family = "LegacyComputing" },
}

if fs.platform().is_win then
  Config.font_size = 10.5
elseif fs.platform().is_mac then
  Config.font_size = 15
else
  Config.font_size = 10.5
end

-- Config.underline_position = -2.5
-- Config.underline_thickness = "2px"
Config.warn_about_missing_glyphs = false

return Config
