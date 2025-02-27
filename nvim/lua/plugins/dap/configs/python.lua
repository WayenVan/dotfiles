-- set up python dap it was set by nvim-dap-python
local dap = require("dap")

-- modify configurations provided by  dap-python, so the cwd is always the root of the project
local extra_cfgs = {}
for _, config in pairs(dap.configurations.python) do
  local function cwd()
    return vim.fn.getcwd()
  end
  if config.name == "file" then
    config.cwd = cwd
    local extened_cfg = vim.deepcopy(config)
    extened_cfg.name = "file (Not just my code)"
    extened_cfg.justMyCode = false
    vim.list_extend(extra_cfgs, { extened_cfg })
  end
  if config.name == "file:args" then
    config.cwd = cwd
    local extened_cfg = vim.deepcopy(config)
    extened_cfg.name = "file:args (Not just my code)"
    extened_cfg.justMyCode = false
    vim.list_extend(extra_cfgs, { extened_cfg })
  end
end
vim.list_extend(dap.configurations.python, extra_cfgs)

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
