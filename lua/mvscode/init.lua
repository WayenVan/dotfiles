vim.g.mapleader = " "
local vs = require("vscode-neovim")

vs.notify("Start loading neovim settings")

require("mvscode.configs.keymappings")
require("mvscode.configs.cmds")
require("mvscode.configs.lazy")
require("mvscode.configs.opts")

vs.notify("Neovim settings loaded")

