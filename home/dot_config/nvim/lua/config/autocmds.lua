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
    if vim.g.neovide_scale_factor then
      vim.g.NEOVIDESCALEFACTOR = vim.g.neovide_scale_factor
    end
  end,
})

vim.filetype.add({
  pattern = {
    [".*%.md%.j2"] = "jinja",
  },
})

-- LazyVim turns on spell for markdown, which underlines code words and CJK/English mixes
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = false
  end,
})
