-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--remove keybindings
-- vim.keymap.del("n", "<A-j>")
-- vim.keymap.del("n", "<A-k>")
-- vim.keymap.del("n", "<C-j>")
-- vim.keymap.del("n", "<C-k>")
-- vim.keymap.del("n", "<C-l>")
-- vim.keymap.del("n", "<C-h>")

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

-- diable git mappping from LazyVim
vim.keymap.del("n", "<leader>gB", {})
map("n", "<leader>gO", LazyVim.lazygit.browse, { desc = "Git Browse" })

-- terminal send esc to shell
map("t", "<c-[>", "<Esc>", { silent = true })

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

-- neovide setting
vim.keymap.set("n", "<leader>uv", "<cmd>VideScale<cr>", { desc = "Neovide scaler factor" })
