local M = {}

function M.mergeTables(table1, table2)
  -- Create a new table to hold the merged results
  local merged = {}

  -- Copy all entries from the first table
  for key, value in pairs(table1) do
    merged[key] = value
  end
  -- Copy entries from the second table, skipping existing keys
  for key, value in pairs(table2) do
    if merged[key] == nil then
      merged[key] = value
    else
      print("Skipping key: " .. tostring(key) .. " as it already exists.")
    end
  end
  return merged
end

return M
