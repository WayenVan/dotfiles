-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
-- -- Yank to the system clipboard by default
-- groups
map("n", "<leader>n", "", { desc = "+noice/neoconfig" })
map("n", "<leader>z", "", { desc = "+zen" })

map("n", "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("v", "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank to clipboard" })

-- Paste from the system clipboard by default
map("n", "<leader>p", '"+p', { desc = "paste from clipboard" })
map("v", "<leader>p", '"+p', { desc = "paste from clipboard" })
map("n", "<leader>P", '"+P', { desc = "paste from clipboard" })

-- lazyvim extra
map("n", "<leader>l", "", { desc = "LazyVim" })
map("n", "<leader>lx", "", { desc = "Lazy" })
map("n", "<leader>lx", "<cmd>LazyExtras<cr>", { desc = "Lazy Extras" })
map("n", "<leader>lc", function()
  LazyVim.news.changelog()
end, { desc = "LazyVim Changelog" })
map("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy Packages" })

-- diable space t
-- map("n", "<space>t", "<Nop>")
-- map("n", "<space>T", "<Nop>")
-- map("n", "<space>l", "<Nop>")
-- map("n", "<space>L", "<Nop>")
-- map("n", "<space>z", "<Nop>")

-- terminal send esc to shell
map("t", "<c-[>", "<Esc>", { silent = true })

-- server settings
map("n", "<leader>sv", "", { desc = "+nvim server" })
map("n", "<leader>svv", "<cmd>ServerSelect<cr>", { desc = "Server delete" })
map("n", "<leader>svc", "<cmd>ServerClear<cr>", { desc = "Server clear" })
map("n", "<leader>svs", "<cmd>ServerStart<cr>", { desc = "Server start" })

-- cutomized text object
local function select_above()
  local line = vim.fn.line(".")
  local cmd = string.format("normal! ggV%dgg", line)
  vim.cmd(cmd)
end
local function select_below()
  local line = vim.fn.line(".")
  local cmd = string.format("normal! GV%dgg", line)
  vim.cmd(cmd)
end
vim.keymap.set("n", "gA", select_above, { desc = "select above" })
vim.keymap.set("n", "gB", select_below, { desc = "select below" })
