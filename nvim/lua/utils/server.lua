local M = {}

local t = {
  pickers = require("telescope.pickers"),
  finders = require("telescope.finders"),
  sorters = require("telescope.sorters"),
  actions = require("telescope.actions"),
  action_state = require("telescope.actions.state"),
  themes = require("telescope.themes"),
  conf = require("telescope.config").values,
}

local n = require("noice")

M.server_picker = function()
  local opts = t.themes.get_dropdown({})
  local finder = t.finders.new_dynamic({
    fn = function()
      local servers = vim.fn.serverlist()
      return servers
    end,
  })
  t.pickers
    .new(opts, {
      prompt_title = "Press <CR> to stop server",
      finder = finder,
      sorter = t.conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, map)
        local stop_server = function()
          local selection = t.action_state.get_selected_entry()
          if vim.fn.serverstop(selection.value) then
            n.notify("Server stopped", "info")
            t.actions.remove_selection(prompt_bufnr)
          else
            n.notify("Server not stopped or not found", "error")
          end

          local current_picker = t.action_state.get_current_picker(prompt_bufnr)
          current_picker:refresh()
        end
        map("i", "<CR>", stop_server)
        map("n", "<CR>", stop_server)
        return true
      end,
    })
    :find()
end

M.setup = function()
  vim.api.nvim_create_user_command("ServerSelect", function()
    M.server_picker()
  end, {})
  local map = vim.keymap.set
  -- server settings
  map("n", "<leader>sv", "", { desc = "+nvim server" })
  map("n", "<leader>svd", "<cmd>ServerSelect<cr>", { desc = "Server delete" })
  map("n", "<leader>svc", "<cmd>ServerClear<cr>", { desc = "Server clear" })
  map("n", "<leader>sva", "<cmd>ServerStart<cr>", { desc = "Server start" })

  -- server command settings
  vim.api.nvim_create_user_command("ServerStart", function()
    local addr = vim.fn.input("Enter the server address")
    if addr ~= nil and addr ~= "" then
      local result = vim.fn.serverstart(addr)
      require("noice").notify(string.format("A nvim server start at %s", result), "info")
    end
  end, {})

  vim.api.nvim_create_user_command("ServerClear", function()
    local addrs = vim.fn.serverlist()
    if #addrs == 0 then
      require("noice").notify("No server running", "info")
      return
    end
    for _, addr in ipairs(addrs) do
      vim.fn.serverstop(addr)
    end
  end, {})
end

return M
