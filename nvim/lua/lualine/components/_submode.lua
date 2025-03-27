local M = require("lualine.component"):extend()

function M:init(options)
  options.icon = options.icon or { "󰇴", color = { link = "WarningMsg" } }
  M.super.init(self, options)
end

function M:update_status()
  local submodes = require("submode").mode()
  if submodes then
    return submodes
  end
  return "no submodes"
end

return M
