local M = {}

local function misc()
  return require("utils.misc")
end

local function load_telescope()
  return {
    pickers = require("telescope.pickers"),
    finders = require("telescope.finders"),
    sorters = require("telescope.sorters"),
    actions = require("telescope.actions"),
  }
end

M.server_picker = misc.create_lazy_var(function()
  local t = load_telescope()
  return t.pickers.new({}, {
    prompt_title = "Custom selection",
    t.finders.new_dynamic({
      fn = function(_, prompt)
        local servers = vim.fn.serverlist()
        return servers
      end,
    }),
  })
end)
