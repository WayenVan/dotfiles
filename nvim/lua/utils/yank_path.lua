local M = {}

function M.yank_path(modifier, path)
  if not path then
    return
  end
  local modified = vim.fn.fnamemodify(path, modifier)

  vim.fn.setreg('"', modified)
  vim.fn.setreg("+", modified)

  vim.notify(("Copied: `%s` to unnamed and plus register"):format(modified), "info")
end

function M.yank_path_picker(filepath)
  local modify = vim.fn.fnamemodify
  local filename = modify(filepath, ":t")

  local vals = {
    ["BASENAME"] = modify(filename, ":r"),
    ["EXTENSION"] = modify(filename, ":e"),
    ["FILENAME"] = filename,
    ["PATH (CWD)"] = modify(filepath, ":."),
    ["PATH (HOME)"] = modify(filepath, ":~"),
    ["PATH"] = filepath,
    ["URI"] = vim.uri_from_fname(filepath),
  }

  local options = vim.tbl_filter(function(val)
    return vals[val] ~= ""
  end, vim.tbl_keys(vals))
  if vim.tbl_isempty(options) then
    vim.notify("No values to copy", vim.log.levels.WARN)
    return
  end
  table.sort(options)
  vim.ui.select(options, {
    prompt = "Choose to copy to clipboard:",
    format_item = function(item)
      return ("%s: %s"):format(item, vals[item])
    end,
  }, function(choice)
    local result = vals[choice]
    if result then
      if vim.fn.has("clipboard") == 0 then
        require("noice").notify("Clipboard is not available", "warn")
      end
      vim.notify(("Copied: `%s` to uname and plus register"):format(result))
      vim.fn.setreg('"', result)
      vim.fn.setreg("+", result)
    end
  end)
end

return M
