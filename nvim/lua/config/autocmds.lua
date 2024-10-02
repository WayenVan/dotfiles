-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- save the color scheme and its background
vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
  -- pattern = "background",
  callback = function()
    vim.g.BACKGROUND = vim.opt.background:get()
    vim.g.COLORSCHEME = vim.g.colors_name
  end,
})
