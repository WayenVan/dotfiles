local M = {}
local battery_info_fallback = {
  {
    state = "Charging",
    state_of_charge = 1.0,
    time_to_full = nil,
    time_to_empty = nil,
    vendor = "unknown",
    model = "unknown",
    serial = "unknown",
  },
}

function M.get_battery_info()
  local battery_info = require("wezterm").battery_info()
  if #battery_info == 0 then
    return battery_info_fallback
  end
  return battery_info
end

return M
