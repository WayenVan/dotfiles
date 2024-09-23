local M = {}

--- @param lsp_name? string
function M.get_python_lsp(lsp_name)
  lsp_name = lsp_name or "pyright"

  local no = require("noice")
  local lsp_clients = vim.lsp.get_clients({ name = lsp_name })

  if #lsp_clients < 1 then
    no.notify("No python lsp server found", "error")
    return nil
  elseif #lsp_clients >= 1 then
    local client = lsp_clients[1]
    if #lsp_clients > 1 then
      no.notify("Found more than one lsp server for python, using the first one", "warn")
    end
    return client
  end
end

function M.get_conda_prefix()
  local conda_prefix = vim.fn.getenv("CONDA_PREFIX")
  if conda_prefix == nil or conda_prefix == "" or conda_prefix == vim.NIL then
    return nil
  else
    return conda_prefix
  end
end

function M.resolve_venv()
  local candidates = {}

  -- check conda
  local conda_prefix = M.get_conda_prefix()
  if conda_prefix then
    candidates[#candidates + 1] = "conda"
  end
  -- check resolved environment
  if #candidates < 1 then
    return nil
  elseif #candidates == 1 then
    return candidates[1]
  else
    error("multiple activated venvs found")
  end
end

function M.get_venv_info()
  local type = M.resolve_venv()
  if type == nil then
    return "none"
  end
  local ret = {
    type = type,
  }
  if type == "conda" then
    ret.conda_prefix = M.get_conda_prefix()
    ret.name = tostring(vim.fn.getenv("CONDA_DEFAULT_ENV"))
    ret.activate_cmd = "conda activate " .. ret.name
  end
  return ret
end

-- conda example
-- {
-- type = "conda",
-- conda_prefix = "xxxxxxxxx/env/dl"
-- name = "dl",
-- activate_cmd = "conda activate dl"
-- }

--- return "none" if no venv is activated other wise return venv_info
local venv_info = M.get_venv_info()
return venv_info, M
