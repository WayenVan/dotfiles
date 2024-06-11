if vim.g.vscode then
  require("mvscode.settings")
else
  -- bootstrap lazy.nvim, LazyVim and your plugins
  require("config.lazy")
end
