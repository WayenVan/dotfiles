if vim.g.vscode then
  require("mvscode")
else
  -- bootstrap lazy.nvim, LazyVim and your plugins
  require("config.lazy")
  -- auto sourcing
  require("utils.file").auto_sourcing()
end
