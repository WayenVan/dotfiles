---Ported from: https://github.com/olivercederborg/poimandres.nvim
---@module "picker.assets.colorschemes.poimandres"
---@author sravioli
---@license GNU-GPLv3

---@class PickList
local M = {}

local color = require("utils").fn.color

M.scheme = {
  background = "#1B1E28",
  foreground = "#E4F0FB",
  cursor_bg = "#A6ACCD",
  cursor_fg = "#1B1E28",
  cursor_border = "#A6ACCD",
  compose_cursor = "#FCC5E9",
  selection_bg = "#506477",
  selection_fg = "#E4F0FB",
  scrollbar_thumb = "#303340",
  split = "#171922",
  visual_bell = "#506477",
  ansi = {
    "#171922",
    "#D0679D",
    "#5DE4C7",
    "#FFFAC2",
    "#89DDFF",
    "#FCC5E9",
    "#89DDFF",
    "#FFFFFF",
  },
  brights = {
    "#506477",
    "#D0679D",
    "#5DE4C7",
    "#FFFAC2",
    "#ADD7FF",
    "#FCC5E9",
    "#ADD7FF",
    "#FFFFFF",
  },
  indexed = { [16] = "#5DE4C7", [17] = "#D0679D" },
  copy_mode_active_highlight_bg = { Color = "#506477" },
  copy_mode_active_highlight_fg = { Color = "#E4F0FB" },
  copy_mode_inactive_highlight_bg = { Color = "#303340" },
  copy_mode_inactive_highlight_fg = { Color = "#E4F0FB" },
  quick_select_label_bg = { Color = "#D0679D" },
  quick_select_label_fg = { Color = "#E4F0FB" },
  quick_select_match_bg = { Color = "#FFFAC2" },
  quick_select_match_fg = { Color = "#E4F0FB" },
  tab_bar = {
    background = "#171922",
    inactive_tab_edge = "#171922",
    active_tab = { bg_color = "#1B1E28", fg_color = "#E4F0FB", italic = false },
    inactive_tab = { bg_color = "#171922", fg_color = "#506477", italic = false },
    inactive_tab_hover = { bg_color = "#171922", fg_color = "#767C9D", italic = false },
    new_tab = { bg_color = "#171922", fg_color = "#506477", italic = false },
    new_tab_hover = { bg_color = "#171922", fg_color = "#767C9D", italic = true },
  },
}

function M.get()
  return { id = "poimandres", label = "Poimandres" }
end

function M.activate(Config, callback_opts)
  local theme = M.scheme
  color.set_scheme(Config, theme, callback_opts.id)
end

return M
