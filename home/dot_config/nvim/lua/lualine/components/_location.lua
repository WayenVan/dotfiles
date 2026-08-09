local M = require("lualine.component"):extend()
local hl = require("lualine.highlight")

local function progress()
  local cur = vim.fn.line(".")
  local total = vim.fn.line("$")
  if cur == 1 then
    return "Top"
  elseif cur == total then
    return "Bot"
  else
    return string.format("%2d%%%%", math.floor(cur / total * 100))
  end
end

function M:update_status()
  local suffix = hl.get_mode_suffix()
  local line = vim.fn.line(".")
  local col = vim.fn.virtcol(".")
  local progress = progress()
  local proc = "%#lualine_a" .. suffix .. "# " .. progress .. " "
  local ret = string.format("[%d:%d] ", line, col)
  ret = "%#lualine_b" .. suffix .. "#" .. ret .. proc .. "%#lualine_c_normal#"
  return ret
end

return M
