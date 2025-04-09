local M = {}

-- Usage example:
-- lazy_var = create_lazy_var(function()
--   print("Initializing value...")
--   return 42 -- This is the value that will be initialized.
-- end)

-- Accessing lazy_var:
-- print(lazy_var()) -- Output: 42 (Initialization doesn't happen again)
--- @param init_function function
function M.create_lazy_var(init_function)
  local value
  local initialized = false

  return function()
    if not initialized then
      value = init_function()
      initialized = true
    end
    return value
  end
end

function M.cleanShareData()
  local pl = require("plenary.path")
  local path = pl:new(vim.fn.stdpath("data")):joinpath("shada")
  path:rmdir()
end

function M.shellescape_dir(path)
  local is_windows = vim.fn.has("win32") == 1
  if is_windows then
    -- Windows: Use double quotes and escape existing quotes with double quotes
    local escaped = path:gsub('"', '""')
    return '"' .. escaped .. '"'
  else
    -- Linux/macOS: Use single quotes and escape existing single quotes
    local escaped = path:gsub("'", "'\\''")
    return "'" .. escaped .. "'"
  end
end

return M
