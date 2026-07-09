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

---@param opts? {relative: "cwd"|"root", length: number?}
---@return string, string -- dir, filename (纯文本)
function M.pretty_path_parts(opts)
  opts = vim.tbl_extend("force", {
    buf = vim.api.nvim_get_current_buf(),
    relative = "cwd",
    length = 3,
  }, opts or {})

  local path = vim.api.nvim_buf_get_name(opts.buf)
  if path == "" then
    return "", ""
  end

  path = LazyVim.norm(path)
  local root = LazyVim.root.get({ normalize = true })
  local cwd = LazyVim.root.cwd()
  local norm_path = path

  if LazyVim.is_win() then
    norm_path = norm_path:lower()
    root = root:lower()
    cwd = cwd:lower()
  end

  if opts.relative == "cwd" and norm_path:find(cwd, 1, true) == 1 then
    path = path:sub(#cwd + 2)
  elseif norm_path:find(root, 1, true) == 1 then
    path = path:sub(#root + 2)
  end

  local sep = package.config:sub(1, 1)
  local parts = vim.split(path, "[\\/]")

  if opts.length == 0 then
    -- keep everything
  elseif #parts > opts.length then
    parts = { parts[1], "…", unpack(parts, #parts - opts.length + 2, #parts) }
  end

  local dir = ""
  if #parts > 1 then
    dir = table.concat({ unpack(parts, 1, #parts - 1) }, sep)
  end
  local filename = parts[#parts] or ""

  return dir, filename
end

return M
