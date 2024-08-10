local vs = require("vscode-neovim")
-- custom key maps
local map = vim.keymap.set

-- settings for tabs
map("n", "H", function()
  vs.action("workbench.action.previousEditor")
end, {})
map("n", "L", function()
  vs.action("workbench.action.nextEditor")
end, {})

-- setting for panel and bar
map("n", "<leader><leader>", function()
  vs.action("workbench.action.quickOpen")
end, {})
map("n", "<leader>p", function()
  vs.action("workbench.action.showCommands")
end, {})
map("n", "<leader>f", function()
  vs.action("editor.action.formatDocument")
end, {})
map("v", "<leader>f", function()
  vs.action("editor.action.formatSelection")
end, {})

-- sett select all
map({ "n", "v" }, "<c-a>", function()
  vs.action("editor.action.selectAll")
end, {})

-- save file
map({ "n", "v" }, "<c-s>", function()
  vs.action("workbench.action.files.save")
end, {})

-- tab moving
map({ "n", "v" }, "<leader>bl", function()
  vs.action("workbench.action.moveEditorToNextGroup")
end, {})
map({ "n", "v" }, "<leader>bh", function()
  vs.action("workbench.action.moveEditorToPreviousGroup")
end, {})

-- tab management
map({ "n", "v" }, "<leader>bd", function()
  vs.action("workbench.action.closeActiveEditor")
end, {})
map({ "n", "v" }, "<leader>bD", function()
  vs.action("workbench.action.closeEditorsInGroup")
end, {})

-- toggle explorer
map({ "n", "v" }, "<leader>e", function()
  vs.action("workbench.files.action.focusFilesExplorer")
end, {})

-- toggle terminal
map({ "n", "v" }, "<leader>t", function()
  vs.action("workbench.action.terminal.toggleTerminal")
end, {})

-- search
map({ "n", "v" }, "<leader>ss", function()
  vs.action("workbench.action.gotoSymbol")
end, {})

-- copy paste
-- -- Yank to the system clipboard by default
map('n', '<leader>y', '"+y')
map('v', '<leader>y', '"+y')
map('n', '<leader>Y', '"+Y')

-- Paste from the system clipboard by default
map('n', '<leader>p', '"+p')
map('v', '<leader>p', '"+p')
map('n', '<leader>P', '"+P')

-- set for ui
map({ "n", "v" }, "<leader>ue", function()
  vs.action("workbench.action.toggleSidebarVisibility")
end, {})
map({ "n", "v" }, "<leader>ub", function()
  vs.action("workbench.action.toggleAuxiliaryBar")
end, {})
map({ "n", "v" }, "<leader>up", function()
  vs.action("workbench.action.togglePanel")
end, {})



local opts = { noremap = true, silent = true }
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("v", "<", "<gv", opts)
