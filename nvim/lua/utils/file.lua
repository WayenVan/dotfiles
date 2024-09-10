local M = {}

local p = require("plenary.path")
local no = require("noice")

function M.auto_source()
  local nvim_lua_file = p:new(vim.fn.getcwd()):joinpath(".nvim.lua")
  local exist = nvim_lua_file:exists() and nvim_lua_file:is_file()
  if not exist then
    return false
  end
  local loaded_list = vim.g.loaded_rc_files
  if not loaded_list then
    loaded_list = {}
  end
  if vim.list_contains(loaded_list, nvim_lua_file:absolute()) then
    no.notify(".nvim.lua already loaded, skip", "info")
    return false
  end
  vim.cmd("luafile " .. nvim_lua_file:absolute())
  vim.list_extend(loaded_list, { nvim_lua_file:absolute() })
  no.notify(".nvim.lua sourcing finished", "info")
  vim.g.loaded_rc_files = loaded_list
  return true
end

return M
