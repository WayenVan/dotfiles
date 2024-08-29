local M = {}

local p = require("plenary.path")
local no = require("noice")


function M.auto_source()
  local nvim_lua_file = p:new(vim.fn.getcwd()):joinpath(".nvim.lua")
  local exist = nvim_lua_file:exists() and nvim_lua_file:is_file()
  if exist then
    if vim.list_contains(UserState.loaded_init_files, nvim_lua_file:absolute()) then
      no.notify(".nvim.lua already loaded, skip", "info")
      return false
    end
    vim.cmd("luafile " .. nvim_lua_file:absolute())
    vim.list_extend(UserState.loaded_init_files, { nvim_lua_file:absolute() })
    no.notify(".nvim.lua sourcing finished", "info")
    return true
  end
  return false
end

return M
