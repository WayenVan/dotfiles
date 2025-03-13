return {
  {
    "rmagatti/auto-session",
    lazy = false,
    -- dependencies = {
    --   "nvim-telescope/telescope.nvim", -- Only needed if you want to use sesssion lens
    -- },
    -- enabled = false,
    opts = {
      silent_restore = true,
      auto_session_enabled = true,
      auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
      auto_save_enabled = true,
      auto_restore_enabled = true,
      auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
      auto_session_allowed_dirs = nil,
      auto_session_create_enabled = false,
      auto_session_enable_last_session = false,
      auto_session_use_git_branch = false,
      auto_restore_lazy_delay_enabled = true,
      log_level = "error",
      session_lens = {
        -- If load_on_setup is false, make sure you use `:SessionSearch` to open the picker as it will initialize everything first
        load_on_setup = false,
        theme_conf = { border = true },
        previewer = true,
        mappings = {
          -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
          delete_session = { "i", "<C-D>" },
          alternate_session = { "i", "<C-S>" },
        },
      },
    },
    keys = {
      { "-", "", desc = "+session" },
      { "--", "<cmd>Autosession search<cr>", desc = "Search sessions" },
      { "-s", "<cmd>SessionSave<cr>", desc = "Save session" },
      { "-d", "<cmd>SessionDelete<cr>", desc = "Delete current session" },
      { "-D", "<cmd>Autosession delete<cr>", desc = "Delete sessions" },
    },
  },
  {
    "rmagatti/auto-session",
    opts = function(_, opts)
      local function open_minifile()
        local minifile = require("mini.files")
        minifile.open(nil, true)
      end

      local function close_minifile()
        local minifile = require("mini.files")
        minifile.close()
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

      local function noice_dismiss()
        require("noice").cmd("dismiss")
      end

      -- opts.post_restore_cmds = { open_minifile }
      -- do the cleaning job before saving so avoid any possible errors
      opts.pre_save_cmds = { close_minifile, delete_not_good_buffer, noice_dismiss }
    end,
  },
}
