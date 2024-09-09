return {
  name = "run python",
  condition = {
    filetype = "python",
  },
  builder = function(params)
    local python_cmd = LazyVim.is_win() and "python" or "python3"
    local cmd = python_cmd
    local file = vim.fn.expand("%:p")
    local args = { file }

    -- check venv
    local venv_info, _ = require("utils.python")
    if venv_info then
      if venv_info.type == "conda" and venv_info.name ~= "base" then
        cmd = "conda"
        args = {
          "run",
          "-n",
          venv_info.name,
          python_cmd,
          file,
        }
      end
    end

    return {
      name = vim.fn.expand("%:t"),
      cmd = cmd,
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
