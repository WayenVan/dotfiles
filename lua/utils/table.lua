local M = {}

function M.deep_merge(t1, t2)
  t1 = vim.deepcopy(t1)
  for k, v in pairs(t2) do
    if type(v) == "table" and type(t1[k]) == "table" then
      -- If both t1[k] and t2[k] are tables, recursively merge them
      M.deep_merge(t1[k], v)
    else
      -- Otherwise, overwrite t1's value with t2's value
      t1[k] = v
    end
  end
  return t1
end

return M
