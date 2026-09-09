local M = {}

---@class Lspeek.SnacksPreview
---@field preview lspeek.Preview
---@field target lspeek.Preview.Target
---@field main_win integer

---@type table<integer, Lspeek.SnacksPreview>
local previews = {}

---@type table<integer, true>
local mapped_buffers = {}

local pruning = false

local function prune_previews()
  pruning = false

  for win in pairs(previews) do
    if not vim.api.nvim_win_is_valid(win) then
      previews[win] = nil
    end
  end

  for buf in pairs(mapped_buffers) do
    local is_used = false
    for _, state in pairs(previews) do
      if state.target.buf == buf then
        is_used = true
        break
      end
    end

    if not is_used then
      if vim.api.nvim_buf_is_valid(buf) then
        pcall(vim.keymap.del, "n", "<C-o>", { buffer = buf })
      end
      mapped_buffers[buf] = nil
    end
  end
end

local function schedule_prune()
  if pruning then
    return
  end
  pruning = true
  vim.schedule(prune_previews)
end

local function feed_normal_ctrl_o()
  vim.api.nvim_feedkeys(vim.keycode("<C-o>"), "n", false)
end

---@param state Lspeek.SnacksPreview
local function pick_target_window(state)
  local preview_win = state.preview.win
  if not preview_win or not vim.api.nvim_win_is_valid(preview_win) then
    schedule_prune()
    return
  end

  local snacks = require("snacks")
  local target_win = snacks.picker.util.pick_win({
    main = vim.api.nvim_win_is_valid(state.main_win) and state.main_win or nil,
  })

  -- Keep the preview open when window selection is cancelled.
  if not target_win or not vim.api.nvim_win_is_valid(target_win) then
    return
  end

  local cursor = vim.api.nvim_win_get_cursor(preview_win)
  local path = state.target.full_path

  require("lspeek").close_all()
  previews = {}
  prune_previews()

  if not vim.api.nvim_win_is_valid(target_win) then
    return
  end

  vim.api.nvim_win_call(target_win, function()
    vim.cmd.edit(vim.fn.fnameescape(path))
    pcall(vim.api.nvim_win_set_cursor, target_win, cursor)
  end)
  vim.api.nvim_set_current_win(target_win)
end

---@param buf integer
local function ensure_ctrl_o_mapping(buf)
  if mapped_buffers[buf] then
    return
  end

  mapped_buffers[buf] = true
  vim.keymap.set("n", "<C-o>", function()
    local state = previews[vim.api.nvim_get_current_win()]
    if state then
      pick_target_window(state)
      return
    end

    -- A stale buffer-local mapping must not shadow Vim's jump-list command.
    prune_previews()
    feed_normal_ctrl_o()
  end, {
    buffer = buf,
    desc = "Open lspeek target in a selected window",
    nowait = true,
    silent = true,
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

  local parent = previews[source.win]
  local main_win = parent and parent.main_win or source.win
  previews[preview.win] = { preview = preview, target = target, main_win = main_win }
  ensure_ctrl_o_mapping(target.buf)
  pcall(vim.api.nvim_win_set_cursor, preview.win, util.lsp_pos_to_vim_cursor(target.pos))
end

vim.api.nvim_create_autocmd({ "WinClosed", "WinEnter", "WinLeave" }, {
  callback = schedule_prune,
  desc = "Clean up lspeek picker integration state",
})

return M
