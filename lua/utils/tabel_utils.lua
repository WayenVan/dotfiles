local table_utils = {}

function table_utils.printTable(t)
  for key, value in pairs(t) do
    print(key, value)
  end
end

return table_utils
