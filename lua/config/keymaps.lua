-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set
-- -- Yank to the system clipboard by default
map("n", "<leader>y", '"+y', { desc = "Yank from clipboard " })
map("v", "<leader>y", '"+y', { desc = "Yank from clipboard " })
map("n", "<leader>Y", '"+Y', { desc = "Yank from clipboard " })

-- Paste from the system clipboard by default
map("n", "<leader>p", '"+p', { desc = "paste to clipboard" })
map("v", "<leader>p", '"+p', { desc = "paste to clipboard" })
map("n", "<leader>P", '"+P', { desc = "paste to clipboard" })

-- Floating terminal
local lazyterm = function()
  LazyVim.terminal(nil, { cwd = LazyVim.root() })
end
map("n", "<leader>t", lazyterm, { desc = "Terminal (Root Dir)" })
map("n", "<leader>T", function()
  LazyVim.terminal()
end, { desc = "Terminal (cwd)" })

-- Window settings
map("n", "<c-w>m", "<c-w>|", { desc = "Max out width" })

-- session settings
map("n", "<leader>qS", "<cmd>SessionSave<cr>", { desc = "Save session" })
map("n", "<leader>qs", "<cmd>SessionSearch<cr>", { desc = "Search sessions" })
