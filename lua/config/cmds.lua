-- customised cmds
--
local function noice()
  return require("noice")
end

--- auto source the .nvim.lua file
vim.api.nvim_create_user_command("AutoSource", function()
  local result = require("utils.file").auto_source()
  if result == false then
    noice().notify("No .nvim.lua found", "info")
  end
end, {})

-- server command settings
vim.api.nvim_create_user_command("ServerStart", function()
  local addr = vim.fn.input("Enter the server address")
  local result = vim.fn.serverstart(addr)
  noice().notify(string.format("A nvim server start at %s", result), "info")
end, {})

vim.api.nvim_create_user_command("ServerClear", function()
  local addrs = vim.fn.serverlist()
  if #addrs == 0 then
    require("noice").notify("No server running", "info")
    return
  end
  for _, addr in ipairs(addrs) do
    vim.fn.serverstop(addr)
  end
end, {})
