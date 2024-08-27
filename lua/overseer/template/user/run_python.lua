return {
  name = "run python",
  condition = {
    filetype = "python",
  },
  builder = function(params)
    return {
      name = vim.fn.expand("%:t"),
      cmd = LazyVim.is_win() and "python" or "python3",
      cwd = vim.fn.getcwd(),
      args = { vim.fn.expand("%:p") },
      components = {
        "display_duration",
        "on_exit_set_status",
        "on_complete_notify",
      },
    }
  end,
}
