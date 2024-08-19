-- this file auto run after lazya configed

local utils = require("utils.misc")
local python_utils = require("utils.python")

-- global user state
UserState = {
  -- conda info --json result, if not installed, the value should be nil
  conda_info = utils.create_lazy_var(function()
    return python_utils.get_conda_info()
  end),
  loaded_init_files = {},
}

-- swiwtching ui by time
local f = LazyVim.toggle("background", { values = { "light", "dark" }, name = "Background" })
local date = os.date("*t")
if (tonumber(date.hour) >= 8) and (tonumber(date.hour) <= 19) then
  f()
end

-- source .nvim.lu once after startup
require("utils.file").auto_source()
