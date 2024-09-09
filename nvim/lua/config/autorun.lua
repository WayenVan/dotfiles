-- this file auto run after lazya configed

local storage = require("utils.storage")

UserStorage = storage.get_storage()

-- set background
vim.opt.background = UserStorage.background

-- source .nvim.lu once after startup
require("utils.file").auto_source()

-- neovide settings
vim.g.neovide_scale_factor = UserStorage.neovide_scale_factor
vim.o.guifont = "JetBrainsMono Nerd Font:h14"

-- filetype
vim.filetype.add({
  filename = {
    [".condarc"] = "yaml", -- Set filetype to 'python' for a file named 'mycustomfile'
    [".fishrc"] = "fish",
  },
  extension = {},
  pattern = {},
})
