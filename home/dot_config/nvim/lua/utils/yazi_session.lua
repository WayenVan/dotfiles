-- Session state lives only in this Lua module, never on disk.
local M = {}
local snapshot, token
local actions = {}

local function usable(path)
  return type(path) == "string" and (path:find("://", 1, true) ~= nil or vim.fn.isdirectory(path) == 1)
end

local function restorable()
  if not snapshot then
    return
  end
  local saved = { active = 1, tabs = {} }
  for i, tab in ipairs(snapshot.tabs) do
    if usable(tab.cwd) then
      local copy = vim.deepcopy(tab)
      -- Don't restore a cursor onto a file which has since disappeared.
      if copy.hovered and not copy.hovered:find("://", 1, true) and not vim.uv.fs_stat(copy.hovered) then
        copy.hovered = nil
      end
      saved.tabs[#saved.tabs + 1] = copy
      if i == snapshot.active then
        saved.active = #saved.tabs
      end
    end
  end
  return #saved.tabs > 0 and saved or nil
end

function M.setup()
  local group = vim.api.nvim_create_augroup("YaziMemorySession", { clear = true })
  vim.api.nvim_create_autocmd("User", {
    group = group,
    pattern = "YaziDDSCustom",
    callback = function(ev)
      if ev.data.type ~= "nvim-session" then
        return
      end
      local ok, body = pcall(vim.json.decode, ev.data.raw_data)
      if not ok or type(body) ~= "table" or body.token ~= token then
        return
      end
      if type(body.action) == "string" and actions[body.action] then
        actions[body.action](body)
      elseif type(body.snapshot) == "table" then
        local incoming = body.snapshot
        if type(incoming.tabs) == "table" and #incoming.tabs > 0 and incoming.tabs[incoming.active] then
          snapshot = incoming
        end
      end
    end,
  })
end

function M.ready(buffer, config, api, saved)
  -- The plugin invokes this hook from a fast event.
  vim.schedule(function()
    if not vim.api.nvim_buf_is_valid(buffer) then
      return
    end
    token = tostring(vim.fn.getpid()) .. ":" .. tostring(vim.uv.hrtime())
    local request = vim.json.encode({ token = token, snapshot = saved })
    -- This quoted string is parsed by Yazi's plugin argument parser, not a shell.
    api:emit_to_yazi({ "plugin", "nvim-session", vim.fn.shellescape(request) })
    local function go_cwd()
      api:emit_to_yazi({ "cd", "--str", vim.fn.getcwd() })
    end
    local function go_root(body)
      if type(body.path) ~= "string" or body.path == "" then
        return
      end
      local file_buffer = vim.fn.bufadd(body.path)
      local root = LazyVim.root.get({ buf = file_buffer })
      api:emit_to_yazi({ "cd", "--str", root })
    end
    local switching_explorer = false
    local function close_then(open)
      if switching_explorer then
        return
      end
      switching_explorer = true
      local current = snapshot and snapshot.tabs[snapshot.active]
      local hovered = current and current.hovered
      local cwd = current and current.cwd
      local on_closed = config.hooks.yazi_closed_successfully
      config.hooks.yazi_closed_successfully = function(chosen, cfg, state)
        config.hooks.yazi_closed_successfully = on_closed
        if on_closed then
          on_closed(chosen, cfg, state)
        end
        if chosen == nil then
          local directory = state.last_directory.filename
          -- Wait for Yazi's window/buffer cleanup before opening the next UI.
          vim.schedule(function()
            open(directory, cwd == directory and hovered or nil)
          end)
        end
      end
      api:emit_to_yazi({ "quit" })
    end
    local function open_oil()
      close_then(function(directory)
        require("oil").open_float(directory, { preview = false })
      end)
    end
    local function reveal_fyler()
      close_then(function(directory, hovered)
        require("utils.fyler").reveal(hovered or directory)
      end)
    end
    local function copy_path(body)
      if type(body.path) ~= "string" or body.path == "" then
        return
      end
      close_then(function()
        -- Let terminal-exit mode changes settle before Snacks enters Insert mode.
        vim.defer_fn(function()
          require("utils.yank_path").yank_path_picker(body.path)
        end, 50)
      end)
    end
    actions = {}
    for name, action in pairs({ cwd = go_cwd, root = go_root, oil = open_oil, fyler = reveal_fyler, copy_path = copy_path }) do
      actions[name] = function(body)
        if vim.api.nvim_buf_is_valid(buffer) then
          action(body)
        end
      end
    end
  end)
end

function M.open()
  local saved = restorable()
  local directory = saved and saved.tabs[saved.active].cwd or vim.fn.getcwd()
  require("yazi").yazi({
    hooks = {
      on_yazi_ready = function(buffer, config, api)
        M.ready(buffer, config, api, saved)
      end,
    },
  }, directory)
end

return M
