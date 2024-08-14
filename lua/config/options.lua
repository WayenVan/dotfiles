-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- neovide settings
if vim.g.neovide then
  vim.g.neovide_cursor_antialiasing = true
  vim.g.neovide_scale_factor = 1.0
  vim.o.guifont = "JetBrainsMono Nerd Font:h14"
end
