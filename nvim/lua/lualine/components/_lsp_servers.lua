local M = require("lualine.component"):extend()

function M:init(options)
  options.icon = options.icon or { "󰌘", color = { fg = "#fca644" } }
  options.split = options.split or ","
  M.super.init(self, options)
end

function M:update_status()
  local buf_clients = nil

  if vim.lsp.get_clients ~= nil then
    -- buf_get_client is deprecated in nvim >=0.10.0
    buf_clients = vim.lsp.get_clients({ bufnr = 0 })
  else
    buf_clients = vim.lsp.get_clients()
  end

  -- null-ls support, not if the plugin is not loaded, will not show null-ls
  local null_ls_loaded = false
  local null_ls = nil
  local null_ls_installed = false

  if require("lazy.core.config").plugins["null-ls"] then
    null_ls_loaded = true
    null_ls_installed, null_ls = pcall(require, "null-ls")
  end
  local buf_client_names = {}
  for _, client in pairs(buf_clients) do
    if client.name == "null-ls" and null_ls_loaded then
      if null_ls_installed and null_ls ~= nil then
        for _, source in ipairs(null_ls.get_source({ filetype = vim.bo.filetype })) do
          table.insert(buf_client_names, source.name)
        end
      end
    else
      table.insert(buf_client_names, client.name)
    end
  end
  return table.concat(buf_client_names, self.options.split)
end

return M
