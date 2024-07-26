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

-- settings for leader
map("n", "<leader>s", function()
  vs.action("workbench.action.files.save")
end, {})
map("n", "<leader>q", function()
  vs.action("workbench.action.closeActiveEditor")
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
