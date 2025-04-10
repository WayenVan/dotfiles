local M = require("lualine.component"):extend()

function M:init(options)
  M.super.init(self, options)
end

function M:update_status()
  local icon = ""
  local layers = LayersManager.activated_layers
  -- vim.notify(vim.inspect(layers))
  if #layers == 0 then
    return nil
  end
  local layers_string = table.concat(layers, ", ")
  local ret = icon .. " " .. layers_string
  return ret
end

return M
