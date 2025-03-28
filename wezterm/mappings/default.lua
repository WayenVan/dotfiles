---@module "mappings.default"
---@author sravioli
---@license GNU-GPLv3

---@diagnostic disable-next-line: undefined-field
local act = require("wezterm").action
local key = require("utils.fn").key
local wezterm = require "wezterm"

local Config = {}

Config.disable_default_key_bindings = true
Config.leader = { key = "b", mods = "CTRL", timeout_milliseconds = math.maxinteger }

local mappings = {
  { "<C-Tab>", act.ActivateTabRelative(1), "next tab" },
  { "<C-S-Tab>", act.ActivateTabRelative(-1), "prev tab" },
  { "<M-CR>", act.ToggleFullScreen, "fullscreen" },
  { "<C-S-c>", act.CopyTo "Clipboard", "copy" },
  { "<C-S-v>", act.PasteFrom "Clipboard", "paste" },
  { "<C-S-f>", act.Search "CurrentSelectionOrEmptyString", "search" },
  { "<C-S-k>", act.ClearScrollback "ScrollbackOnly", "clear scrollback" },
  { "<C-S-p>", act.ActivateCommandPalette, "command palette" },
  { "<C-S-r>", act.ReloadConfiguration, "reload config" },
  { "<leader>t", act.SpawnTab "CurrentPaneDomain", "new pane" },
  { "<leader>n", act.SpawnWindow, "new window" },
  { "<leader>l", act.ShowDebugOverlay, "debug overlay" },
  { "<leader>d", act.CloseCurrentPane { confirm = true }, "delete panel" },
  { "<leader>q", act.QuitApplication, "quit application" },
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
  { "<leader>v", act.SplitHorizontal { domain = "CurrentPaneDomain" }, "vsplit" },
  { "<leader>s", act.SplitVertical { domain = "CurrentPaneDomain" }, "hsplit" },
  { "<C-S-h>", act.ActivatePaneDirection "Left", "move left" },
  { "<C-S-j>", act.ActivatePaneDirection "Down", "mode down" },
  { "<C-S-k>", act.ActivatePaneDirection "Up", "move up" },
  { "<C-S-l>", act.ActivatePaneDirection "Right", "move right" },
  { "<C-S-[>", act.ActivateTabRelative(-1), "next tab" },
  { "<C-S-]>", act.ActivateTabRelative(1), "prev tab" },
  --for uk keymap
  { "<C-S-{>", act.ActivateTabRelative(-1), "next tab" },
  { "<C-S-}>", act.ActivateTabRelative(1), "prev tab" },

  -- my mappings for fat
  -- { "<C-S-1>", wezterm.action { ActivateTab = 0 } },
  -- { "<C-S-2>", wezterm.action { ActivateTab = 1 } },
  -- { "<C-S-3>", wezterm.action { ActivateTab = 2 } },
  -- { "<C-S-4>", wezterm.action { ActivateTab = 3 } },
  -- { "<C-S-5>", wezterm.action { ActivateTab = 4 } },
  -- { "<C-S-6>", wezterm.action { ActivateTab = 5 } },
  -- { "<C-S-7>", wezterm.action { ActivateTab = 6 } },
  -- { "<C-S-8>", wezterm.action { ActivateTab = 7 } },
  -- { "<C-S-9>", wezterm.action { ActivateTab = -1 } },
  { "<leader>1", wezterm.action { ActivateTab = 0 } },
  { "<leader>2", wezterm.action { ActivateTab = 1 } },
  { "<leader>3", wezterm.action { ActivateTab = 2 } },
  { "<leader>4", wezterm.action { ActivateTab = 3 } },
  { "<leader>5", wezterm.action { ActivateTab = 4 } },
  { "<leader>6", wezterm.action { ActivateTab = 5 } },
  { "<leader>7", wezterm.action { ActivateTab = 6 } },
  { "<leader>8", wezterm.action { ActivateTab = 7 } },
  { "<leader>9", wezterm.action { ActivateTab = -1 } },

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
  { "<leader>/", act.Search "CurrentSelectionOrEmptyString", "search mode" },
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
