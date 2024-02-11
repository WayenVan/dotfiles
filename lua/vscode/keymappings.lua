local vscode = require("vscode-neovim")
-- custom key maps
local map = vim.keymap.set

-- settings for tabs
map("n", "gh", function()
  vscode.action("workbench.action.previousEditor")
end, {})
map("n", "gl", function()
  vscode.action("workbench.action.nextEditor")
end, {})

-- setting for panel and bar
map("n", "<leader><leader>", function()
  vscode.action("workbench.action.quickOpen")
end, {})
map("n", "<leader>p", function()
  vscode.action("workbench.action.showCommands")
end, {})
map("n", "<leader>f", function()
  vscode.action("editor.action.formatDocument")
end, {})
map("v", "<leader>f", function()
  vscode.action("editor.action.formatSelection")
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

-- goto defination and reference
-- map({ "n", "v" }, "gd", function()
--   vscode.action("editor.action.revealDefinition")
-- end, {})
-- map({ "n", "v" }, "gr", function()
--   vscode.action("editor.action.goToReferences")
-- end, {})

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
