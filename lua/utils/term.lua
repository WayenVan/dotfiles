local M = {}

local function load_toggleterm()
  local t = require("toggleterm.terminal")
  return t
end

---@param config TermCreateArgs
function M.create_terminal(config)
  -- set defualt values
  local t = load_toggleterm()
  t.Terminal:new(config):toggle()
end

-- cutomized local terminal
local storage = {
  lazygit_cwd = nil,
  lazygit_root = nil,
  lazygit_log_cwd = nil,
  lazygit_log_root = nil,
}

function M.lazygit_cwd()
  if not storage.lazygit_cwd then
    storage.lazygit_cwd = load_toggleterm().Terminal:new({
      cmd = "lazygit",
      dir = vim.fn.getcwd(),
      direction = "float",
      close_on_exit = true,
      hidden = false,
      display_name = "LazyGitCwd",
    })
  end
  storage.lazygit_cwd:toggle()
end

function M.lazygit_root()
  if not storage.lazygit_root then
    storage.lazygit_root = load_toggleterm().Terminal:new({
      cmd = "lazygit",
      dir = LazyVim.root(),
      direction = "float",
      close_on_exit = true,
      hidden = false,
      display_name = "LazyGitRoot",
    })
  end
  storage.lazygit_root:toggle()
end

function M.lazygit_log_cwd()
  if not storage.lazygit_log_cwd then
    storage.lazygit_log_cwd = load_toggleterm().Terminal:new({
      cmd = "lazygit log",
      dir = vim.fn.getcwd(),
      direction = "float",
      close_on_exit = true,
      hidden = false,
      display_name = "LazyGitLog",
    })
  end
  storage.lazygit_log_cwd:toggle()
end

function M.lazygit_log_root()
  if not storage.lazygit_log_root then
    storage.lazygit_log_root = load_toggleterm().Terminal:new({
      cmd = "lazygit log",
      dir = LazyVim.root(),
      direction = "float",
      close_on_exit = true,
      hidden = false,
      display_name = "LazyGitLog",
    })
  end
  storage.lazygit_log_root:toggle()
end

-- clear all stored terminal
function M.clear_storage()
  for key, value in pairs(storage) do
    if value ~= nil then
      value:shutdown()
      storage[key] = nil
    end
  end
end

return M
