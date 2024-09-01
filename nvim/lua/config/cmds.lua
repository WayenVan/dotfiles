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
  if addr ~= nil and addr ~= "" then
    local result = vim.fn.serverstart(addr)
    noice().notify(string.format("A nvim server start at %s", result), "info")
  end
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

vim.api.nvim_create_user_command("ServerSelect", function()
  require("utils.pickers").server_picker()
end, {})

vim.api.nvim_create_user_command("VideScale", function()
  local factor = vim.fn.input("Enter the Scaler Factor")
  if factor ~= "" and factor ~= nil then
    factor = tonumber(factor)
    if factor then
      vim.g.neovide_scale_factor = factor
      noice().notify("Neovide Facotr Set to " .. tostring(factor), "info")
    else
      noice().notify("Invalid Factor", "error")
    end
  end
end, {})

vim.api.nvim_create_user_command("Http", function()
  local port = vim.fn.input("Enter the port", "8080")
  require("utils.term").create_terminal({
    cmd = "http-server" .. " -p" .. port,
  })
end, {})
