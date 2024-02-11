local vscode = require("vscode-neovim")
-- custom key maps
local map = vim.keymap.set

-- settings for tabs
map("n", "th", function()
  vscode.action("workbench.action.previousEditor")
end, {})
map("n", "tl", function()
  vscode.action("workbench.action.nextEditor")
end, {})

-- setting for panel and bar
map("n", "<leader>p", function()
  vscode.action("workbench.action.togglePanel")
end, {})
map("n", "<leader>b", function()
  vscode.action("workbench.action.toggleAuxiliaryBar")
end, {})
map("n", "<leader>e", function()
  vscode.action("workbench.action.toggleSidebarVisibility")
end, {})

-- sett select all
map({ "n", "v" }, "<c-a>", function()
  vscode.action("editor.action.selectAll")
end, {})

-- settings for leader
map("n", "<leader>s", function()
  vscode.action("workbench.action.files.save")
end, {})
map("n", "<leader>q", function()
  vscode.action("workbench.action.closeActiveEditor")
end, {})

-- setting for find
map({ "n", "v" }, "?", function()
  vscode.action("actions.find")
end, {})
map({ "n", "v" }, "/", function()
  vscode.action("actions.find")
end, {})

-- toggle
map({ "n", "v" }, "<c-t>", function()
  vscode.action("workbench.action.terminal.toggleTerminal")
end, {})

-- goto defination and reference
map({ "n", "v" }, "gd", function()
  vscode.action("editor.action.revealDefinition")
end, {})
map({ "n", "v" }, "gr", function()
  vscode.action("editor.action.goToReferences")
end, {})

-- try hop
-- place this in one of your configuration file(s)
local hop = require("hop")
local directions = require("hop.hint").HintDirection
vim.keymap.set("", "f", function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
end, { remap = true })
vim.keymap.set("", "F", function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
end, { remap = true })
vim.keymap.set("", "t", function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, { remap = true })
vim.keymap.set("", "T", function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, { remap = true })
