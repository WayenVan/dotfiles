-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- neovide settings
vim.g.neovide_scale_factor = 1.0
vim.o.guifont = "JetBrainsMono Nerd Font:h14"
if LazyVim.is_win() then
  vim.g.neovide_scale_factor = 0.85
end

-- sessiont setting
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
