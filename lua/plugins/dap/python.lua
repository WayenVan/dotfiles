-- set up python dap it was set by nvim-dap-python
local dap = require("dap")

-- modify configurations provided by  dap-python, so the cwd is always the root of the project
for _, config in pairs(dap.configurations.python) do
  local function cwd()
    return vim.fn.getcwd()
  end

  if config.name == "Launch file" then
    config.cwd = cwd
  end
  if config.name == "Launch file with arguments" then
    config.cwd = cwd
  end
end

-- dap.adapters.mypy = function(cb, config)
--   cb({
--     type = "executable",
--     command = "debugpy",
--     args = { "-m", "debugpy.adapter" },
--   })
-- end
--
-- local configs = dap.configurations.python
-- table.insert(configs, {
--   type = "mypy",
--   request = "launch",
--   name = "Launch mmmmmmmm file",
--   program = "${file}",
--   pythonPath = function()
--     return vim.fn.exepath("python")
--   end,
-- })
