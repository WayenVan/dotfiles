---@class TermManager
---@field last_term_count? number

TermManager = {}
TermManager.__index = TermManager

function TermManager:new()
  local obj = {}
  setmetatable(obj, TermManager)
  obj.last_term_count = nil
  return obj
end

function TermManager:open()
  local count = vim.v.count
  if count == 0 then
    count = self.last_term_count or 1
  end
  Snacks.terminal(nil, { cwd = LazyVim.root(), count = count })
  self.last_term_count = count
end

return TermManager
