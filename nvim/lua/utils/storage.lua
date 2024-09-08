local M = {}

local p = require("plenary.path")
local no = require("noice")

local default_storage = {
  -- name shoulbe be the same as the global variable
  neovide_scale_factor = 1.0,
  background = "dark",
}

function M.get_storage()
  local storage_file = p:new(vim.fn.stdpath("data")):joinpath("storage.json")
  local exist = storage_file:exists() and storage_file:is_file()
  if not exist then
    return default_storage
  else
    local file = io.open(storage_file:absolute(), "r")
    if file then
      local content = file:read("*a")
      local storage = vim.fn.json_decode(content)
      if storage then
        storage = vim.tbl_deep_extend("force", default_storage, storage)
        no.notify("Storage loaded in " .. storage_file:absolute(), "info")
        return storage
      else
        no.notify("json decode failed get:\n" .. vim.inspect(storage), "info")
      end
    else
      no.notify("Failed to read storage", "error")
      return default_storage
    end
  end
end

function M.update_storage(storage)
  storage.neovide_scale_factor = vim.g.neovide_scale_factor
  storage.background = vim.opt.background:get()
end

function M.save_storage(storage)
  M.update_storage(storage)
  local storage_file = p:new(vim.fn.stdpath("data")):joinpath("storage.json")
  local file = io.open(storage_file:absolute(), "w")
  if file then
    file:write(vim.fn.json_encode(storage))
    file:close()
  else
    no.notify("Failed to save storage", "error")
  end
end

return M