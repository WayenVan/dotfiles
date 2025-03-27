local M = require("lualine.component"):extend()

function M:init(options)
  options.icon = options.icon or { "󰇴", color = { link = "WarningMsg" } }
  M.super.init(self, options)
end

function M:update_status()
  local mode = _Hydra.mode
  if mode then
    return mode
  end
  return nil
end

return M
