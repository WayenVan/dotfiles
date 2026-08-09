local M = {}
local dap = require("dap")

--- @param file_type string
--- @param config dap.Configuration
function M.add_configuration(file_type, config)
  if dap.configurations[file_type] then
    table.insert(dap.configurations[file_type], config)
  else
    dap.configurations[file_type] = { config }
  end
end

return M
