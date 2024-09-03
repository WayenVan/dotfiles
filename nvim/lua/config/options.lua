-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- using powershell setting
if LazyVim.is_win() then
  -- Set PowerShell as the default shell
  vim.o.shell = "pws"
  vim.o.shellcmdflag = "-Command"
  vim.o.shellquote = '"'
  vim.o.shellxquote = ""
end

-- local misc = require("utils.misc")

-- sessiont setting
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- clipboard
vim.opt.clipboard = ""
-- vim.opt.winbar = "%f"

vim.opt.mouse = "a"
