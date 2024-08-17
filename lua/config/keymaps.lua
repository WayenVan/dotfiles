-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
-- -- Yank to the system clipboard by default

map("n", "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("v", "<leader>y", '"+y', { desc = "Yank to clipboard" })
map("n", "<leader>Y", '"+Y', { desc = "Yank to clipboard" })

-- Paste from the system clipboard by default
map("n", "<leader>p", '"+p', { desc = "paste from clipboard" })
map("v", "<leader>p", '"+p', { desc = "paste from clipboard" })
map("n", "<leader>P", '"+P', { desc = "paste from clipboard" })

--- floating terminals
local lazyterm = function()
  LazyVim.terminal(nil, { cwd = LazyVim.root() })
end
map("n", "<leader>t", lazyterm, { desc = "Terminal (Root Dir)" })
map("n", "<leader>T", function()
  LazyVim.terminal()
end, { desc = "Terminal (cwd)" })

-- neoconf
map("n", "<leader>os", "<cmd>Neoconf show<cr>", { desc = "(S)how neoconf" })

-- lazyvim extra
map("n", "<leader>lx", "", { desc = "Lazy" })
map("n", "<leader>lx", "<cmd>LazyExtras<cr>", { desc = "Lazy Extras" })
map("n", "<leader>lc", function()
  LazyVim.news.changelog()
end, { desc = "LazyVim Changelog" })
map("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy Packages" })

-- diable space t
map("n", "<space>t", "<Nop>")
map("n", "<space>T", "<Nop>")
map("n", "<space>l", "<Nop>")
map("n", "<space>L", "<Nop>")
