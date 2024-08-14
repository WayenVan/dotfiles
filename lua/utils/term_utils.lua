local ret = {}

local t = require("toggleterm.terminal")

---@param config TermCreateArgs
function ret.creat_terminal(config)
  t.Terminal:new(config):toggle()
end

return ret
