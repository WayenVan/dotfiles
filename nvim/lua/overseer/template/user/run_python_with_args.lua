return {
  name = "run python with args",
  condition = {
    filetype = "python",
  },
  params = {
    args = { optional = false, type = "list", delimiter = " " },
  },
  builder = function(params)
    local function append_running_args(args)
      if params.args ~= nil then
        vim.list_extend(args, params.args)
      end
    end

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

    -- append running args
    append_running_args(args)

    -- seup name
    local name = vim.fn.expand("%:t") .. "\n"
    for i, arg in ipairs(params.args) do
      name = name .. arg .. "\n"
    end
    return {
      name = name,
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
