local M = {}

-- Usage example:
-- lazy_var = create_lazy_var(function()
--   print("Initializing value...")
--   return 42 -- This is the value that will be initialized.
-- end)

-- Accessing lazy_var:
-- print(lazy_var()) -- Output: Initializing value... 42
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

function M.error_exist_str(str)
  if str:lower():find("error") then
    return true
  else
    return false
  end
end

function M.remove_first_nlines(str, n)
  local pattern = ("[^\n]*\n"):rep(n)
  return str:gsub(pattern, "", 1)
end

function M.execute_shell_command(cmd)
  return vim.fn.system(cmd)
end
return M
