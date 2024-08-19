local u = require("utils.misc")
local n = require("noice")

-- result = vim.json.decode(result)
--
--
vim.api.nvim_input("hello")

vim.print("Enter")
local a = vim.fn.getcharstr()
n.notify(a, "info")
n.notify(tostring(vim.uv.version()), "info")
n.notify(vim.inspect(UserState.loaded_init_files), "info")
