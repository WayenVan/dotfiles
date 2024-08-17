local no = require("noice")
local u = require("utils.misc")

local result = UserState.conda_info()
-- result = vim.json.decode(result)
no.notify(vim.inspect(result), "info")
