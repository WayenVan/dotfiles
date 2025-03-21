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
    local Path = require("plenary.path")
    local system = require("utils.os_name").get_os_name()

    -- check venv
    local venv_info, _ = require("utils.venv")
    if venv_info then
      if venv_info.type == "conda" and venv_info.name ~= "base" then
        if system == "Windows" then
          cmd = Path:new(venv_info.conda_prefix):joinpath("python.exe"):absolute()
        else
          cmd = Path:new(venv_info.conda_prefix):joinpath("bin", "python"):absolute()
        end
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
        { "on_start_change_compiler", compiler = "python" },
      },
    }
  end,
}
