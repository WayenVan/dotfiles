local p = require("plenary.path")

local u_table = require("utils.table")
local a = p:new(vim.fn.stdpath("data"))
local no = require("noice")

print(a:joinpath("sessions"):exists())

default_storage = {
  -- name shoulbe be the same as the global variable
  neovide_scale_factor = 1.0,
}

function get_storage()
  local storage_file = p:new(vim.fn.stdpath("data"))
  storage_file:joinpath("storage.json")
  local exist = storage_file:exists()
  local file = io.open(storage_file:absolute(), "w")
  if file then
    if not exist then
      return default_storage
    else
      local content = file:read("*a")
      local storage = vim.fn.json_decode(content)
      u_table.deep_merge(default_storage, storage)
    end
  else
    no.nofity("Failed to read storage", "error")
    return default_storage
  end
end

function update_storage(storage)
  for k, v in pairs(storage) do
    storage[k] = vim.g[k]
  end
end

function save_storage(storage)
  local storage_file = p:new(vim.fn.stdpath("data"))
  storage_file:joinpath("storage.json")
  local file = io.open(storage_file:absolute(), "w")
  if file then
    file:write(vim.fn.json_encode(storage))
    file:close()
  else
    no.nofity("Failed to save storage", "error")
  end
end
