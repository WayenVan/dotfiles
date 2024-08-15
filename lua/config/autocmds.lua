-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
--
--

vim.api.nvim_create_augroup("AutoSourceNvimLua", { clear = true })

-- Create an autocommand to run when entering a directory
vim.api.nvim_create_autocmd({ "DirChanged" }, {
  group = "AutoSourceNvimLua",
  callback = function()
    require("utils.file").auto_sourcing()
  end,
})
