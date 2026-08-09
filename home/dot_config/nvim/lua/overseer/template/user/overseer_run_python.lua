return {
  name = "run python",
  condition = {
    filetype = "python",
  },
  builder = function(params)
    local python_cmd = LazyVim.is_win() and "python" or "python3"
    local file = vim.fn.expand("%:p")
    local args = { file }
    local Path = require("plenary.path")
    local system = require("utils.os_name").get_os_name()

    local python_path_abs = vim.system({ python_cmd, "-c", "import sys; print(sys.executable)" }):wait()
    local python_path = python_path_abs.stdout:gsub("\n", "")
    local cmd = python_path
    vim.notify("Python path: " .. python_path, vim.log.levels.INFO)

    return {
      name = vim.fn.expand("%:t"),
      cmd = cmd,
      cwd = vim.fn.getcwd(),
      args = args,
      components = {
        "display_duration",
        "on_exit_set_status",
        "on_complete_notify",
        { "on_start_change_compiler", compiler = "python" },
      },
    }
  end,
}
