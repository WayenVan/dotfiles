local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local nvscode = require("vscode-neovim")

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

nvscode.notify("lazy loading plugins")
require("lazy").setup({
  { import = "mvscode.plugins" },
  {
    "vscode-neovim/vscode-multi-cursor.nvim",
    event = "VeryLazy",
    config = function()
      require("vscode-multi-cursor").setup({
        default_mappings = true,
        no_selection = false,
      })
    end,
    cond = not not vim.g.vscode,
    opts = {},
  },
})
