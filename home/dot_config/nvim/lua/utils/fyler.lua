local M = {}

function M.reveal(target)
  local fyler = require("fyler")
  local finder = require("fyler.finder")
  local instance = finder.instance_get_or_nil()
  if instance then
    instance:open()
  else
    fyler.open()
    instance = finder.instance_get_or_nil()
  end
  if not instance or not vim.uv.fs_stat(target) then
    return
  end

  local path = require("fyler.lib.path")
  local root = instance.state.pseudo_root_path
  -- Keep the existing tree root unless the target lies outside it.
  if target ~= root and not vim.fs.relpath(root, target) then
    root = path.common_ancestor(root, target) or "/"
    instance:visit({ path = root })
  end

  local function show(entry)
    local pattern = "^" .. entry:gsub("([^%w])", "%%%1") .. "$"
    local visible = instance.cache.ui.hidden_items.always_visible
    if not vim.tbl_contains(visible, pattern) then
      visible[#visible + 1] = pattern
    end
  end
  show(target)
  -- Expand ancestors so nested files can be revealed without entering their folder.
  local relative = vim.fs.relpath(root, vim.fs.dirname(target))
  local current = root
  for segment in (relative or ""):gmatch("[^/]+") do
    current = vim.fs.joinpath(current, segment)
    instance.state:toggle(current, true)
    show(current)
  end
  instance:refresh({
    recursive = true,
    callback = function()
      if not vim.api.nvim_win_is_valid(instance.win_id) then
        return
      end
      local state = require("fyler.state")
      local id = state.store_path_id[path.to_key(target)]
      if id and instance._id_to_line[id] then
        instance._view.lnum = instance._id_to_line[id]
      end
    end,
  })
end

return M
