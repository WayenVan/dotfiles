-- this file auto run after lazya configed
-- auto sourcing
require("utils.file").auto_source()
local no = require("noice")

-- swiwtching ui by time
local f = LazyVim.toggle("background", { values = { "light", "dark" }, name = "Background" })
local date = os.date("*t")
if (tonumber(date.hour) >= 8) and (tonumber(date.hour) <= 19) then
  f()
end
