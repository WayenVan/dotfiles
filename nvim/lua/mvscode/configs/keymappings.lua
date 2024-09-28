local vs = require("vscode")
-- custom key maps
local map = vim.keymap.set

-- settings for tabs(buffers)
map("n", "H", function()
  vs.action("workbench.action.previousEditorInGroup")
end, {})
map("n", "L", function()
  vs.action("workbench.action.nextEditorInGroup")
end, {})

-- tab moving
map("n", "<leader>bL", function()
  vs.action("workbench.action.moveEditorToNextGroup")
end, {})
map("n", "<leader>bH", function()
  vs.action("workbench.action.moveEditorToPreviousGroup")
end, {})

-- tab management
map("n", "<leader>bd", function()
  vs.action("workbench.action.closeActiveEditor")
end, {})
map("n", "<leader>bD", function()
  vs.action("workbench.action.closeEditorsInGroup")
end, {})
map("n", "<leader>bl", function()
  vs.action("workbench.action.closeEditorsToTheLeft")
end, {})
map("n", "<leader>br", function()
  vs.action("workbench.action.closeEditorsToTheRight")
end, {})

-- setting for panel and bar
map("n", "<leader><leader>", function()
  vs.action("workbench.action.quickOpen")
end, {})

-- settings for go to xxxxxx
map({ "n" }, "gd", function()
  vs.action("editor.action.peekDefinition")
end, {})
map({ "n" }, "gD", function()
  vs.action("editor.action.peekDeclaration")
end, {})
map({ "n" }, "gI", function()
  vs.action("editor.action.peekImplementation")
end, {})
map({ "n" }, "gy", function()
  vs.action("editor.action.peekTypeDefinition")
end, {})
map({ "n" }, "gY", function()
  vs.action("editor.showTypeHierarchy")
end, {})

map({ "n" }, "gb", function()
  vs.action("editor.showTypeHierarchy")
end, {})

-- settings for code
map("n", "<leader>cf", function()
  vs.action("editor.action.formatDocument")
end, {})
map("v", "<leader>cf", function()
  vs.action("editor.action.formatSelection")
end, {})
map("n", "<leader>cs", function()
  vs.action("outline.focus")
end, {})

-- sett select all
map({ "n" }, "vA", function()
  vs.action("editor.action.selectAll")
end, {})

-- toggle explorer
map({ "n" }, "<leader>e", function()
  vs.action("workbench.files.action.focusFilesExplorer")
end, {})

-- toggle terminal
map({ "n" }, "<leader>t", function()
  vs.action("workbench.action.terminal.toggleTerminal")
end, {})

-- search
map({ "n" }, "<leader>ss", function()
  vs.action("workbench.action.gotoSymbol")
end, {})
map({ "n" }, "<leader>sf", function()
  vs.action("actions.find")
end, {})
map({ "n" }, "<leader>sc", function()
  vs.action("editor.action.startFindReplaceAction")
end, {})

-- copy paste
-- -- Yank to the system clipboard by default
map("n", "<leader>y", '"+y')
map("v", "<leader>y", '"+y')
map("n", "<leader>Y", '"+Y')

-- Paste from the system clipboard by default
map("n", "<leader>p", '"+p')
map("v", "<leader>p", '"+p')
map("n", "<leader>P", '"+P')

-- set for ui, explorer, panel, and bar
map({ "n" }, "<leader>ue", function()
  vs.action("workbench.action.toggleSidebarVisibility")
end, {})
map({ "n" }, "<leader>r", function()
  vs.action("workbench.action.toggleAuxiliaryBar")
end, {})
map({ "n" }, "<leader>t", function()
  vs.action("workbench.action.togglePanel")
end, {})
-- theme
map({ "n" }, "<leader>ub", function()
  vs.action("workbench.action.toggleLightDarkThemes")
end, {})

-- set for diagnostics/quickfix
map({ "n" }, "<leader>xx", function()
  vs.action("workbench.panel.markers.view.focus")
end, {})

-- window settings
map({ "n" }, "<c-w>q", function()
  vs.action("workbench.action.closeEditorsInGroup")
end, {})
map({ "n" }, "<c-w>m", function()
  vs.action("workbench.action.toggleEditorWidths")
end, {})

-- window moving
map("n", "<c-h>", function()
  vs.call("workbench.action.navigateLeft")
end)
map("n", "<c-j>", function()
  vs.call("workbench.action.navigateDown")
end)
map("n", "<c-k>", function()
  vs.call("workbench.action.navigateUp")
end)
map("n", "<c-l>", function()
  vs.call("workbench.action.navigateRight")
end)

-- indent
local opts = { noremap = true, silent = true }
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("v", "<", "<gv", opts)

-- debug
map("n", "<leader>db", function()
  vs.action("editor.debug.action.toggleBreakpoint")
end, {})
map("n", "<leader>dt", function()
  vs.action("workbench.panel.repl.view.focus")
end, {})

-- zen mode
map("n", "<leader>zz", function()
  vs.action("workbench.action.toggleZenMode")
end, {})
