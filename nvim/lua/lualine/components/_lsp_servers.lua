local M = require("lualine.component"):extend()
local hl = require("lualine.highlight")

function M:init(options)
  options.split = options.split or ","
  M.super.init(self, options)
end

function M:update_status()
  local buf_clients = nil
  local suffix = hl.get_mode_suffix()
  if vim.lsp.get_clients ~= nil then
    -- buf_get_client is deprecated in nvim >=0.10.0
    buf_clients = vim.lsp.get_clients({ bufnr = 0 })
  else
    buf_clients = vim.lsp.buf_get_clients()
  end
  local null_ls_installed, null_ls = pcall(require, "null-ls")
  local buf_client_names = {}
  for _, client in pairs(buf_clients) do
    if client.name == "null-ls" then
      if null_ls_installed then
        for _, source in ipairs(null_ls.get_source({ filetype = vim.bo.filetype })) do
          table.insert(buf_client_names, source.name)
        end
      end
    else
      table.insert(buf_client_names, client.name)
    end
  end
  local icon = "%#lualine_a" .. suffix .. "#󰌘 "
  local server_string = table.concat(buf_client_names, self.options.split)
  if server_string == "" then
    return ""
  end
  server_string = "%#lualine_b" .. suffix .. "# " .. server_string .. " %#lualine_c_normal#"
  return icon .. server_string
end

return M
