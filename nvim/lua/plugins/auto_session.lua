return {
  {
    "rmagatti/auto-session",
    lazy = false,
    -- dependencies = {
    --   "nvim-telescope/telescope.nvim", -- Only needed if you want to use sesssion lens
    -- },
    -- enabled = false,
    opts = {
      auto_create = false,
      close_unsupported_windows = true,
      session_lens = {
        previewer = true,
      },
    },
    keys = {
      { "-", "", desc = "+session" },
      { "--", "<cmd>AutoSession search<cr>", desc = "Search sessions" },
      { "-s", "<cmd>AutoSession save<cr>", desc = "Save session" },
      { "-d", "<cmd>AutoSession delete<cr>", desc = "Delete current session" },
      { "-D", "<cmd>AutoSession deletePicker<cr>", desc = "Delete sessions" },
    },
  },
  {
    "rmagatti/auto-session",
    opts = function(_, opts)
      local function close_minifile()
        local minifile = require("mini.files")
        minifile.close()
      end
      local function close_minimap()
        require("neominimap").off()
      end
      local function exit_mode()
        require("submode").leave()
        if #LayersManager.activated_layers > 0 then
          for _, layer in ipairs(LayersManager.activated_layers) do
            LayersManager:deactivate(layer)
          end
        end
      end

      local function delete_not_good_buffer()
        -- remove all non-normal buffers
        -- Get a list of all buffer numbers
        local buffers = vim.api.nvim_list_bufs()
        -- Iterate over each buffer
        for _, buf in ipairs(buffers) do
          local buf_type = vim.api.nvim_get_option_value("buftype", { buf = buf })
          -- Check if the buffer is not normal (i.e., buf_type is not empty)
          if buf_type == "nofile" or buf_type == "terminal" then
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end
      end

      local function disable_bqf()
        if require("lazy.core.config").plugins["nvim-bqf"] then
          require("bqf").hidePreviewWindow()
        end
      end

      local function reload_plugins()
        local plugins = { "before.nvim", "codecompanion.nvim", "nvim-dap-view" }
        local reload_plugins = {}
        for _, plugin in ipairs(plugins) do
          if require("lazy.core.config").plugins[plugin] then
            table.insert(reload_plugins, plugin)
          end
        end
        for _, plugin in ipairs(reload_plugins) do
          require("lazy.core.loader").reload(plugin)
          vim.notify("Reloaded " .. plugin)
        end
      end

      local function noice_dismiss()
        require("noice").cmd("dismiss")
      end

      -- opts.post_restore_cmds = { open_minifile }
      -- do the cleaning job before saving so avoid any possible errors
      opts.pre_save_cmds = { disable_bqf, close_minifile, exit_mode, delete_not_good_buffer }
      opts.post_restore_cmds = { reload_plugins }
    end,
  },
}
