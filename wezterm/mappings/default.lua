---@module "mappings.default"
---@author sravioli
---@license GNU-GPLv3

---@diagnostic disable-next-line: undefined-field
local act = require("wezterm").action
local key = require("utils.fn").key
local wezterm = require "wezterm"

local Config = {}

Config.disable_default_key_bindings = true
Config.leader = { key = "Space", mods = "SHIFT", timeout_milliseconds = math.maxinteger }

local mappings = {
  { "<C-Tab>", act.ActivateTabRelative(1), "next tab" },
  { "<C-S-Tab>", act.ActivateTabRelative(-1), "prev tab" },
  { "<M-CR>", act.ToggleFullScreen, "fullscreen" },
  { "<C-S-c>", act.CopyTo "Clipboard", "copy" },
  { "<C-S-v>", act.PasteFrom "Clipboard", "paste" },
  { "<C-S-f>", act.Search "CurrentSelectionOrEmptyString", "search" },
  { "<C-S-k>", act.ClearScrollback "ScrollbackOnly", "clear scrollback" },
  { "<C-S-l>", act.ShowDebugOverlay, "debug overlay" },
  { "<C-S-n>", act.SpawnWindow, "new window" },
  { "<C-S-p>", act.ActivateCommandPalette, "command palette" },
  { "<C-S-r>", act.ReloadConfiguration, "reload config" },
  { "<C-S-t>", act.SpawnTab "CurrentPaneDomain", "new pane" },
  {
    "<C-S-u>",
    act.CharSelect {
      copy_on_select = true,
      copy_to = "ClipboardAndPrimarySelection",
    },
    "char select",
  },
  { "<C-S-w>", act.CloseCurrentTab { confirm = true }, "close tab" },
  { "<C-S-z>", act.TogglePaneZoomState, "toggle zoom" },
  { "<PageUp>", act.ScrollByPage(-1), "" },
  { "<PageDown>", act.ScrollByPage(1), "" },
  { "<C-S-Insert>", act.PasteFrom "PrimarySelection", "" },
  { "<C-Insert>", act.CopyTo "PrimarySelection", "" },
  { "<C-S-Space>", act.QuickSelect, "quick select" },

  ---quick split and nav
  { '<C-S-">', act.SplitHorizontal { domain = "CurrentPaneDomain" }, "vsplit" },
  { "<C-S-%>", act.SplitVertical { domain = "CurrentPaneDomain" }, "hsplit" },
  { "<C-M-h>", act.ActivatePaneDirection "Left", "move left" },
  { "<C-M-j>", act.ActivatePaneDirection "Down", "mode down" },
  { "<C-M-k>", act.ActivatePaneDirection "Up", "move up" },
  { "<C-M-l>", act.ActivatePaneDirection "Right", "move right" },
  -- my mappings for fat
  { "<C-M-1>", wezterm.action { ActivateTab = 0 } },
  { "<C-M-2>", wezterm.action { ActivateTab = 1 } },
  { "<C-M-3>", wezterm.action { ActivateTab = 2 } },
  { "<C-M-4>", wezterm.action { ActivateTab = 3 } },
  { "<C-M-5>", wezterm.action { ActivateTab = 4 } },
  { "<C-M-6>", wezterm.action { ActivateTab = 5 } },
  { "<C-M-7>", wezterm.action { ActivateTab = 6 } },
  { "<C-M-8>", wezterm.action { ActivateTab = 7 } },
  { "<C-M-9>", wezterm.action { ActivateTab = -1 } },

  ---key tables
  { "<leader>h", act.ActivateKeyTable { name = "help_mode", one_shot = true }, "help" },
  {
    "<leader>w",
    act.ActivateKeyTable { name = "window_mode", one_shot = false },
    "window mode",
  },
  {
    "<leader>f",
    act.ActivateKeyTable { name = "font_mode", one_shot = false },
    "font mode",
  },
  { "<leader>c", act.ActivateCopyMode, "copy mode" },
  { "<leader>s", act.Search "CurrentSelectionOrEmptyString", "search mode" },
  { "<leader>p", act.ActivateKeyTable { name = "pick_mode" }, "pick mode" },
}

for i = 1, 24 do
  mappings[#mappings + 1] =
    { "<S-F" .. i .. ">", act.ActivateTab(i - 1), "activate tab " .. i }
end

Config.keys = {}
for _, map_tbl in ipairs(mappings) do
  key.map(map_tbl[1], map_tbl[2], Config.keys)
end

return Config
