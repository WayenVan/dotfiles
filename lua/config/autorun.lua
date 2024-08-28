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

-- swiwtching ui by time
local f = LazyVim.toggle("background", { values = { "light", "dark" }, name = "Background" })
local date = os.date("*t")
if (tonumber(date.hour) >= 8) and (tonumber(date.hour) <= 19) then
  f()
end

-- source .nvim.lu once after startup
require("utils.file").auto_source()

-- neovide settings
vim.g.neovide_scale_factor = UserStorage.neovide_scale_factor
vim.o.guifont = "JetBrainsMono Nerd Font:h14"
-- if LazyVim.is_win() then
--   vim.g.neovide_scale_factor = 0.85
-- elseif misc.isLinux() then
--   vim.g.neovide_scale_factor = 1.15
-- end
--
vim.opt.mouse = "a"
