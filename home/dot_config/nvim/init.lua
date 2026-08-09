if vim.g.vscode then
  -- require("mvscode")
  require("config.lazy")
else
  -- bootstrap lazy.nvim, LazyVim and your plugins
  require("vim._core.ui2").enable({})
  require("config.lazy")
end
