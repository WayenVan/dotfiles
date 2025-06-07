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

map("n", "<Space>", "<Nop>")

-- -- Yank to the system clipboard by default
-- groups
map("n", "<leader>n", "", { desc = "+noice" })
map("n", "<leader>z", "", { desc = "+zen" })

-- lazyvim extra
map("n", "<leader>l", "", { desc = "LazyVim" })
map("n", "<leader>lx", "", { desc = "Lazy" })
map("n", "<leader>lx", "<cmd>LazyExtras<cr>", { desc = "Lazy Extras" })
map("n", "<leader>lc", function()
  LazyVim.news.changelog()
end, { desc = "LazyVim Changelog" })
map("n", "<leader>ll", "<cmd>Lazy<cr>", { desc = "Lazy Packages" })

-- diable git mappping from LazyVim
-- vim.keymap.del("n", "<leader>gB", {})
map("n", "<leader>gO", function()
  Snacks.gitbrowse()
end, { desc = "Git Browse" })

-- terminal send esc to shell
-- map("t", "\\\\", [[<C-\><C-n>]], { silent = true })
-- map("t", "<c-[>", [[<Esc>]], { silent = true })

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
if vim.g.neovide then
  vim.keymap.set("n", "<leader>uv", "<cmd>VideScale<cr>", { desc = "Neovide scaler factor" })
  vim.keymap.set(
    "n",
    "<leader>uV",
    ":let g:neovide_fullscreen = !g:neovide_fullscreen<CR>",
    { desc = "Neovide toggle fullscreen" }
  )
end

-- set toggle mouse setup
Snacks.toggle.option("mouse", { off = nil, on = "a", name = "Mouse" }):map("<leader>uM")
Snacks.toggle
  .new({
    name = "Mouse",
    get = function()
      return vim.opt.mouse._value == "a"
    end,
    set = function(state)
      if state then
        vim.opt.mouse = "a"
      else
        vim.opt.mouse = ""
      end
    end,
  })
  :map("<leader>uM")

-- tab
vim.keymap.set("n", "<M-]>", "<CMD>tabnext<cr>", { desc = "next tab" })
vim.keymap.set("n", "<M-[>", "<CMD>tabprevious<CR>", { desc = "previous tab" })

-- map cmdline up and down
map("c", "<C-d>", "<Down>", {})
map("c", "<C-u>", "<Up>", {})

-- setting up folder
map("n", "<tab>", "za", { desc = "toggle folder", noremap = true, silent = true })

-- set c-i back
vim.keymap.set("n", "<C-i>", "<C-i>", { noremap = true })

local terminal_keymap_autocmd = vim.api.nvim_create_augroup("TerminalKeymap", { clear = true })
-- Setup keymaps for all terminal
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  group = terminal_keymap_autocmd,
  -- group = "ToggleTerm",
  callback = function()
    -- Set terminal-local keymaps
    -- vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { buffer = 0 }) -- Exit terminal mode with Esc
    -- vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { buffer = 0 }) -- Exit terminal mode with Esc
    vim.keymap.set("t", "<M-q>", [[<C-\><C-n>]], { buffer = 0 })
    vim.keymap.set("t", "<C-<localleader>>", [[<C-\><C-n>]], { buffer = 0 })
    vim.keymap.set("t", "<C-h>", "<Cmd>wincmd h<CR>", { buffer = 0 }) -- Move left
    vim.keymap.set("t", "<C-j>", "<Cmd>wincmd j<CR>", { buffer = 0 }) -- Move down
    vim.keymap.set("t", "<C-k>", "<Cmd>wincmd k<CR>", { buffer = 0 }) -- Move up
    vim.keymap.set("t", "<C-l>", "<Cmd>wincmd l<CR>", { buffer = 0 }) -- Move right
  end,
})
-- setup keymaps ihnside the terminal
