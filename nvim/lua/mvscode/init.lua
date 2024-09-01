vim.g.mapleader = " "
local vs = require("vscode")

vs.notify("Start loading neovim settings")

require("mvscode.configs.keymappings")
require("vscode")
require("mvscode.configs.lazy")
require("mvscode.configs.opts")

vs.notify("Neovim settings loaded")
