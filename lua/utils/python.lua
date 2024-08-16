local function load_noice()
  return require("noice")
end

local M = {}

--- @param lsp_name? string
function M.get_python_lsp(lsp_name)
  lsp_name = lsp_name or "pyright"

  local no = load_noice()
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

--- @param lsp_name? string
function M.get_python_path(lsp_name)
  lsp_name = lsp_name or "pyright"

  local lsp_client = M.get_python_lsp(lsp_name)
  if lsp_client == nil then
    return nil
  else
    return lsp_client.config.settings.python.pythonPath
  end
end

return M
