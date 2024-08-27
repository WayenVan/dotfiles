return {
  name = "run python with args",
  condition = {
    filetype = "python",
  },
  params = {
    args = { optional = true, type = "list", delimiter = " " },
  },
  builder = function(params)
    local args = { vim.fn.expand("%:p") }
    if params.args ~= nil then
      vim.list_extend(args, params.args)
    end
    return {
      name = vim.fn.expand("%:t"),
      cmd = LazyVim.is_win() and "python" or "python3",
      cwd = vim.fn.getcwd(),
      args = args,
      components = {
        "display_duration",
        "on_exit_set_status",
        "on_complete_notify",
      },
    }
  end,
}
