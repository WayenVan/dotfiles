return {
  {
    "rmagatti/auto-session",
    lazy = false,
    dependencies = {
      "nvim-telescope/telescope.nvim", -- Only needed if you want to use sesssion lens
    },
    opts = {
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
        load_on_setup = true,
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
      { "<leader>qS", "<cmd>SessionSave<cr>", desc = "Save session" },
      { "<leader>qs", "<cmd>Telescope session-lens<cr>", desc = "Search sessions" },
      { "<leader>qd", "<cmd>Autosession delete<cr>", desc = "Delete sessions" },
      { "<leader>qD", "<cmd>SessionDelete<cr>", desc = "Delete current session" },
    },
  },
  {
    "rmagatti/auto-session",
    opts = function(_, opts)
      local function restore_neo_tree()
        local tree = require("neo-tree.command")
        tree.execute({
          action = "show",
          position = "left",
          dir = vim.fn.getcwd(),
        })
      end
      opts.post_restore_cmds = { restore_neo_tree }
    end,
  },
}
