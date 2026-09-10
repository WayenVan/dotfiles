local M = {}

-- The key that, inside an lspeek preview, closes every preview window and then
-- opens the target in a window you pick. Change this to remap it.
local pick_key = "<C-o>"

local state_var = "lspeek_snacks_target"

---@class Lspeek.SnacksPreview
---@field target lspeek.Preview.Target
---@field main_win integer

---@type table<integer, integer> preview window handle -> target buffer
local active_previews = {}

---@param win integer
---@return Lspeek.SnacksPreview?
local function get_preview_state(win)
  local ok, state = pcall(vim.api.nvim_win_get_var, win, state_var)
  return ok and state or nil
end

local function feed_native_key()
  vim.api.nvim_feedkeys(vim.keycode(pick_key), "n", false)
end

---Remove the pick mapping from a buffer once no preview needs it anymore.
---@param buf integer
local function clear_pick_mapping(buf)
  if vim.api.nvim_buf_is_valid(buf) then
    pcall(vim.keymap.del, "n", pick_key, { buffer = buf })
  end
end

---Drop every tracked preview and its pick mapping.
local function clear_all_pick_mappings()
  for win, buf in pairs(active_previews) do
    active_previews[win] = nil
    clear_pick_mapping(buf)
  end
end

---@param preview_win integer
---@param state Lspeek.SnacksPreview
local function pick_target_window(preview_win, state)
  -- Grab what we need from the preview before it is destroyed.
  local cursor = vim.api.nvim_win_get_cursor(preview_win)
  local path = state.target.full_path
  local main_win = vim.api.nvim_win_is_valid(state.main_win) and state.main_win or nil

  -- Close every preview first, then ask which window to open the target in.
  require("lspeek").close_all()
  -- close_all() suppresses WinClosed, so the WinClosed cleanup never runs here.
  clear_all_pick_mappings()

  -- Snacks auto-selects when only one non-floating window is left (no prompt).
  local target_win = require("snacks").picker.util.pick_win({ main = main_win })
  if not target_win or not vim.api.nvim_win_is_valid(target_win) then
    return
  end

  vim.api.nvim_win_call(target_win, function()
    vim.cmd.edit(vim.fn.fnameescape(path))
    pcall(vim.api.nvim_win_set_cursor, target_win, cursor)
  end)
  vim.api.nvim_set_current_win(target_win)
end

---@param buf integer
local function set_pick_mapping(buf)
  vim.keymap.set("n", pick_key, function()
    local current_win = vim.api.nvim_get_current_win()
    local state = get_preview_state(current_win)

    -- debug: remove once the mapping behaves
    vim.notify(
      ("lspeek %s: win=%d state=%s"):format(pick_key, current_win, tostring(state ~= nil)),
      vim.log.levels.INFO
    )

    if state then
      pick_target_window(current_win, state)
    else
      -- The preview uses the real file buffer, so keep native behavior when
      -- that buffer is displayed in a normal window.
      feed_native_key()
    end
  end, {
    buffer = buf,
    desc = "lspeek: close previews and open target in a picked window",
    nowait = true,
    silent = true,
  })
end

---Track a preview window and remove its pick mapping when it closes.
---@param preview_win integer
---@param buf integer
local function track_preview(preview_win, buf)
  active_previews[preview_win] = buf

  vim.api.nvim_create_autocmd("WinClosed", {
    pattern = tostring(preview_win),
    once = true,
    callback = function()
      active_previews[preview_win] = nil

      for win, tracked_buf in pairs(active_previews) do
        if not vim.api.nvim_win_is_valid(win) then
          active_previews[win] = nil -- prune windows closed with WinClosed suppressed
        elseif tracked_buf == buf then
          return -- another preview still shows this buffer
        end
      end

      clear_pick_mapping(buf)
    end,
  })
end

---@param location lsp.Location|lsp.LocationLink
function M.open_preview(location)
  local util = require("lspeek.util")
  local window = require("lspeek.window")
  local uri = util.normalize_uri(location.uri or location.targetUri)
  local bufnr = util.ensure_loaded_buf(uri)
  local fname = vim.uri_to_fname(uri)
  local source = window.get_source()
  local target = window.build_target_from_location(location, bufnr, fname)
  local preview = window.create_preview_floating_window(source, target)

  if not preview or not preview.win or not vim.api.nvim_win_is_valid(preview.win) then
    return
  end

  local parent = get_preview_state(source.win)
  local main_win = parent and parent.main_win or source.win
  vim.api.nvim_win_set_var(preview.win, state_var, {
    target = target,
    main_win = main_win,
  })

  set_pick_mapping(target.buf)
  track_preview(preview.win, target.buf)
  pcall(vim.api.nvim_win_set_cursor, preview.win, util.lsp_pos_to_vim_cursor(target.pos))

  -- Method A: make sure the preview float actually owns focus. Snacks restores
  -- its layout on a later event-loop turn and can steal focus back, so also
  -- re-assert it once after this turn.
  local function focus_preview()
    if vim.api.nvim_win_is_valid(preview.win) then
      pcall(vim.api.nvim_set_current_win, preview.win)
    end
  end
  focus_preview()
  vim.schedule(focus_preview)
end

return M
