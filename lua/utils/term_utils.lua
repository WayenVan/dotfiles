local ret = {}

local t = require("toggleterm.terminal")

---@param config TermCreateArgs
function ret.create_terminal(config)
  -- set defualt values
  if config.exit_on_close == nil then
    config.exit_on_close = false
  end
  t.Terminal:new(config):toggle()
end

return ret
