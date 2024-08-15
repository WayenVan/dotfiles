-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
--
--

-- Function to check for the existence of a file
local function file_exists(name)
  local f = io.open(name, "r")
  if f then
    f:close()
  end
  return f ~= nil
end

vim.api.nvim_create_augroup("AutoSourceNvimLua", { clear = true })

-- Create an autocommand to run when entering a directory or opening a buffer
vim.api.nvim_create_autocmd({ "BufEnter", "DirChanged" }, {
  group = "AutoSourceNvimLua",
  callback = function()
    local cwd = vim.fn.getcwd()
    local nvim_lua_file = cwd .. "/.nvim.lua"

    if file_exists(nvim_lua_file) then
      vim.cmd("luafile " .. nvim_lua_file)
    end
  end,
})
