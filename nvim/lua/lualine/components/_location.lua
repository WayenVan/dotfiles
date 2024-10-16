local M = require("lualine.component"):extend()
local hl = require("lualine.highlight")

function M:update_status()
  local suffix = hl.get_mode_suffix()
  local line = vim.fn.line(".")
  local col = vim.fn.virtcol(".")
  local icon = "%#lualine_a" .. suffix .. "# 󰍒 "
  local ret = string.format("[%d:%d] ", line, col)
  ret = "%#lualine_b" .. suffix .. "#" .. ret .. icon .. "%#lualine_c_normal#"
  return ret
end

return M
