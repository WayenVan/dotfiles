-- this file auto run after lazya configed

local misc = require("utils.misc")
local python_utils = require("utils.python")
local storage = require("utils.storage")

-- global user state
UserState = {
  -- conda info --json result, if not installed, the value should be nil
  conda_info = misc.create_lazy_var(function()
    return python_utils.get_conda_info()
  end),
  --- maintain a list of loaded init files, prevent duplicate loading
  loaded_init_files = {},
}

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
