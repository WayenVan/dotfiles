local _M = {}
-- venn.nvim: enable or disable keymappings
-- function _M.Toggle_venn()
--   local venn_enabled = vim.inspect(vim.b.venn_enabled)
--   if venn_enabled == "nil" then
--     vim.b.venn_enabled = true
--     vim.cmd([[setlocal ve=all]])
--     -- draw a line on HJKL keystokes
--     vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", { noremap = true })
--     vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", { noremap = true })
--     vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", { noremap = true })
--     vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", { noremap = true })
--     -- draw a box by pressing "f" with visual selection
--     vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", { noremap = true })
--   else
--     vim.cmd([[setlocal ve=]])
--     vim.api.nvim_buf_del_keymap(0, "n", "J")
--     vim.api.nvim_buf_del_keymap(0, "n", "K")
--     vim.api.nvim_buf_del_keymap(0, "n", "L")
--     vim.api.nvim_buf_del_keymap(0, "n", "H")
--     vim.api.nvim_buf_del_keymap(0, "v", "f")
--     vim.b.venn_enabled = nil
--   end
-- end
-- -- toggle keymappings for venn using <leader>v
-- vim.api.nvim_set_keymap("n", "<leader>v", ":lua Toggle_venn()<CR>", { noremap = true })
--

vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = function()
    local orange_hl = vim.api.nvim_get_hl(0, { name = "Orange", link = false })
    vim.api.nvim_set_hl(0, "HydraPopupSurround", { link = "Orange" }) -- change bg as needed
    vim.api.nvim_set_hl(0, "HydraPopupMode", { fg = "#1e222a", bg = orange_hl.fg }) -- change bg as needed
  end,
})

local orange_hl = vim.api.nvim_get_hl(0, { name = "Orange", link = false })
-- Create a new highlight group with the same fg color
vim.api.nvim_set_hl(0, "HydraPopupSurround", { link = "Orange" }) -- change bg as needed
vim.api.nvim_set_hl(0, "HydraPopupMode", { fg = "#1e222a", bg = orange_hl.fg }) -- change bg as needed
--

---@param mode string
---@param keys? table
function _M.hint_popup(mode, keys)
  local Popup = require("nui.popup")
  local NuiLine = require("nui.line")
  local line = NuiLine()
  line:append(" ", "HydraPopupSurround")
  line:append(mode, "HydraPopupMode")
  line:append(" ", "HydraPopupSurround")
  if keys then
    for _, v in ipairs(keys) do
      line:append(v[1], "Keyword")
      line:append(" ", "Normal")
      line:append(v[2], "Normal")
      line:append(", ", "Normal")
    end
  end
  local width = line:width()

  local popup = Popup({
    -- anchor = "SE",
    position = {
      row = vim.o.lines - 3,
      col = "50%",
      -- row ▲ 0,
      -- col = 0,
    },
    size = {
      -- width = math.floor(vim.o.columns * 0.8),
      width = width,
      height = 1,
    },
    enter = false,
    focusable = true,
    zindex = 50,
    relative = "editor",
    border = {
      padding = {
        top = 0,
        bottom = 0,
        left = 0,
        right = 0,
      },
      style = "single",
      text = {
        -- top = " I am top title ",
        -- top_align = "center",
        -- bottom = "I am bottom title",
        -- bottom_align = "left",
      },
    },
    buf_options = {
      modifiable = false,
      readonly = true,
    },
    win_options = {
      winblend = 0,
      winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
    },
  })
  popup:on("WinResized", function()
    popup:update_layout({
      position = {
        row = vim.o.lines - 3,
        col = "50%",
      },
    })
  end)
  line:render(popup.bufnr, -1, 1)
  return popup
end

-- _M.hint_popup({ hello = "this is hello" }):mount()

return _M
