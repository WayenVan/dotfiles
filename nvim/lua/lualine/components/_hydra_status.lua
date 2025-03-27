local M = require("lualine.component"):extend()

function M:init(options)
  options.icon = options.icon or { "󰇴", color = { link = "WarningMsg" } }
  M.super.init(self, options)
end

function M:update_status()
  return vim.g.hydra_mode
end

return M
