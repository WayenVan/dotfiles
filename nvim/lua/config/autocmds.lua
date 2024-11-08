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

-- save the neovide value
vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
  -- pattern = "background",
  callback = function()
    if vim.g.neovid_loaded then
      vim.g.NEOVIDE_SCALE_FACTOR = vim.g.neovide_scale_factor
    end
  end,
})
