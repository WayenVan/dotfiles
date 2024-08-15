local M = {}

local function load_toggleterm()
  local t = require("toggleterm.terminal")
  return t
end

---@param config TermCreateArgs?
function M.create_terminal(config)
  -- set defualt values
  local t = load_toggleterm()
  t.Terminal:new(config):toggle()
end

return M
