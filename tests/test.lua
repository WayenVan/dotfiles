local u = require("utils.misc")
local n = require("noice")

-- result = vim.json.decode(result)
vim.api.nvim_input("hello")

vim.print("Enter")
local a = vim.fn.getcharstr()
n.notify(a, "info")
