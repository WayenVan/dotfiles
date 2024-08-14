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

-- Window settings
map("n", "<c-w>m", "<c-w>|", { desc = "Max out width" })

-- auto signature
map("i", "<c-a-p>", function()
  vim.lsp.buf.signature_help()
end, { desc = "Show function signature" })

-- show neo tree
