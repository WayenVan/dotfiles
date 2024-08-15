local M = {}

-- Function to check for the existence of a file
function M.file_exists(name)
  local f = io.open(name, "r")
  if f then
    f:close()
  end
  return f ~= nil
end

function M.auto_sourcing()
  local no = require("noice")
  local cwd = vim.fn.getcwd()
  local nvim_lua_file = cwd .. "/.nvim.lua"
  if M.file_exists(nvim_lua_file) then
    no.notify(".nvim.lua found, sourcing it", "info")
    vim.cmd("luafile " .. nvim_lua_file)
    no.notify("sourcing finished", "info")
  end
end

return M
