local nvscode = require("vscode-neovim")
-- custom key maps
local map = vim.keymap.set

-- settings for tabs
map("n", "H", function()
  nvscode.action("workbench.action.previousEditor")
end, {})
map("n", "L", function()
  nvscode.action("workbench.action.nextEditor")
end, {})

-- setting for panel and bar
map("n", "<leader><leader>", function()
  nvscode.action("workbench.action.quickOpen")
end, {})
map("n", "<leader>p", function()
  nvscode.action("workbench.action.showCommands")
end, {})
map("n", "<leader>f", function()
  nvscode.action("editor.action.formatDocument")
end, {})
map("v", "<leader>f", function()
  nvscode.action("editor.action.formatSelection")
end, {})

-- sett select all
map({ "n", "v" }, "<c-a>", function()
  nvscode.action("editor.action.selectAll")
end, {})

-- settings for leader
map("n", "<leader>s", function()
  nvscode.action("workbench.action.files.save")
end, {})
map("n", "<leader>q", function()
  nvscode.action("workbench.action.closeActiveEditor")
end, {})

-- goto defination and reference
-- map({ "n", "v" }, "gd", function()
--   vscode.action("editor.action.revealDefinition")
-- end, {})
-- map({ "n", "v" }, "gr", function()
--   vscode.action("editor.action.goToReferences")
-- end, {})
--
local opts = { noremap = true, silent = true }
vim.keymap.set("v", ">", ">gv", opts)
vim.keymap.set("v", "<", "<gv", opts)
