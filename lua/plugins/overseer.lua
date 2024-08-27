return {
  {
    "stevearc/overseer.nvim",
    opts = {
      strategy = "toggleterm",
      default_detail = 3,
      task_list = {
        direction = "right",
      },
    },
    keys = function(_, keys)
      local new_keys = {
        { "<leader>oo", "<cmd>OverseerToggle<cr>", desc = "Task list" },
        { "<leader>oa", "<cmd>OverseerRun<cr>", desc = "Run task" },
        { "<leader>oq", "<cmd>OverseerQuickAction<cr>", desc = "Action recent task" },
        { "<leader>oi", "<cmd>OverseerInfo<cr>", desc = "Overseer Info" },
        -- { "<leader>ob", "<cmd>OverseerBuild<cr>", desc = "Task builder" },
        { "<leader>os", "<cmd>OverseerTaskAction<cr>", desc = "Task action" },
        { "<leader>oc", "<cmd>OverseerClearCache<cr>", desc = "Clear cache" },
        { "<leader>od", "<cmd>OverseerDeleteBundle<cr>", desc = "Delete bundle" },
        { "<leader>ol", "<cmd>OverseerLoadBundle<cr>", desc = "Delete bundle" },
      }

      return new_keys
    end,
  },
}
