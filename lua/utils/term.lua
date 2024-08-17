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

local lazygit_cwd = nil
function M.lazygit_cwd()
  if not lazygit_cwd then
    lazygit_cwd = load_toggleterm().Terminal:new({
      cmd = "lazygit",
      dir = vim.fn.getcwd(),
      direction = "float",
      close_on_exit = true,
      hidden = false,
      display_name = "LazyGitCwd",
    })
  end
  lazygit_cwd:toggle()
end

local lazygit_root = nil
function M.lazygit_root()
  if not lazygit_root then
    lazygit_root = load_toggleterm().Terminal:new({
      cmd = "lazygit",
      dir = LazyVim.root(),
      direction = "float",
      close_on_exit = true,
      hidden = false,
      display_name = "LazyGitRoot",
    })
  end
  lazygit_root:toggle()
end

local lazygit_log_cwd = nil
function M.lazygit_log_cwd()
  if not lazygit_log_cwd then
    lazygit_log_cwd = load_toggleterm().Terminal:new({
      cmd = "lazygit log",
      dir = vim.fn.getcwd(),
      direction = "float",
      close_on_exit = true,
      hidden = false,
      display_name = "LazyGitLog",
    })
  end
  lazygit_log_cwd:toggle()
end

local lazygit_log_root = nil
function M.lazygit_log_root()
  if not lazygit_log_root then
    lazygit_log_root = load_toggleterm().Terminal:new({
      cmd = "lazygit log",
      dir = LazyVim.root(),
      direction = "float",
      close_on_exit = true,
      hidden = false,
      display_name = "LazyGitLog",
    })
  end
  lazygit_log_root:toggle()
end

return M
