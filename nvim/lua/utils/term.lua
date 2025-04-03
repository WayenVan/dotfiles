local M = {}

local t = require("toggleterm.terminal")
local storage = {}

local function create_term(cmd, dir, name)
  return t.Terminal:new({
    cmd = cmd,
    dir = dir,
    direction = "float",
    close_on_exit = true,
    hidden = false,
    display_name = name,
  })
end

---@param config TermCreateArgs
function M.create_terminal(config)
  t.Terminal:new(config):toggle()
end

function M.create_aider()
  local mode_arg = vim.opt.background:get() == "dark" and "--dark-mode" or "--light-mode"
  create_term("aider --no-auto-commits " .. mode_arg, vim.fn.getcwd(), "Aider"):toggle()
end

local lazygit_terms = {
  cwd = { cmd = "lazygit", dir = vim.fn.getcwd(), name = "LazyGitCwd" },
  root = { cmd = "lazygit", dir = LazyVim.root(), name = "LazyGitRoot" },
  log_cwd = { cmd = "lazygit log", dir = vim.fn.getcwd(), name = "LazyGitLog" },
  log_root = { cmd = "lazygit log", dir = LazyVim.root(), name = "LazyGitLog" },
}

for key, spec in pairs(lazygit_terms) do
  M["lazygit_" .. key] = function()
    if not storage[key] then
      storage[key] = create_term(spec.cmd, spec.dir, spec.name)
    end
    storage[key]:toggle()
  end
end

function M.clear_storage()
  for key, term in pairs(storage) do
    if term then
      term:shutdown()
      storage[key] = nil
    end
  end
end

function M.clear_all()
  for _, term in pairs(t.get_all()) do
    term:shutdown()
  end
end

return M
