local M = require("lualine.component"):extend()

function M:init(options)
  options.icon = options.icon or { "󰇴", color = { link = "WarningMsg" } }
  M.super.init(self, options)
end

function M:update_status()
  return require("submode").mode()
end

return M
