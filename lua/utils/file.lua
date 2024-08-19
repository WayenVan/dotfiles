local M = {}

local function string_in_list(s, list)
  for _, v in ipairs(list) do
    if v == s then
      return true
    end
  end
  return false
end

-- Function to check for the existence of a file
function M.file_exists(name)
  local f = io.open(name, "r")
  if f then
    f:close()
  end
  return f ~= nil
end

function M.auto_source()
  local no = require("noice")
  local cwd = vim.fn.getcwd()
  local nvim_lua_file = cwd .. "/.nvim.lua"
  if M.file_exists(nvim_lua_file) then
    if string_in_list(nvim_lua_file, UserState.loaded_init_files) then
      no.notify(".nvim.lua already loaded, skip", "info")
      return false
    end
    vim.cmd("luafile " .. nvim_lua_file)
    table.insert(UserState.loaded_init_files, nvim_lua_file)
    no.notify(".nvim.lua sourcing finished", "info")
    return true
  end
  return false
end

return M
