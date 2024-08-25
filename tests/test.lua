local ui = require("dapui.config")

local icon = require("nvim-web-devicons")

local i, c = icon.get_icon_by_filetype("js")
-- local i, c = icon.get_icon_by_filetype("lua")
print(i, c)
