local M = {}

local p = require("plenary.path")
local no = require("noice")

local function string_in_list(s, list)
  for _, v in ipairs(list) do
    if v == s then
      return true
    end
  end
  return false
end

function M.auto_source()
  local nvim_lua_file = p:new(vim.fn.getcwd()):joinpath(".nvim.lua")
  local exist = nvim_lua_file:exists() and nvim_lua_file:is_file()
  if exist then
    if string_in_list(nvim_lua_file, UserState.loaded_init_files) then
      no.notify(".nvim.lua already loaded, skip", "info")
      return false
    end
    vim.cmd("luafile " .. nvim_lua_file:absolute())
    table.insert(UserState.loaded_init_files, nvim_lua_file)
    no.notify(".nvim.lua sourcing finished", "info")
    return true
  end
  return false
end

return M
