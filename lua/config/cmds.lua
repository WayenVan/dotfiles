-- customised cmds
--

--- auto source the .nvim.lua file
vim.api.nvim_create_user_command("AutoSource", function()
  local result = require("utils.file").auto_source()
  if result == false then
    require("noice").notify("No .nvim.lua found", "info")
  end
end, {})
