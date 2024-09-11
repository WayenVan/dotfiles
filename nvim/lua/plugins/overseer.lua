return {
  {
    "stevearc/overseer.nvim",
    opts = {
      strategy = {
        "toggleterm",
        -- open_on_start = false,
      },
      templates = { "shell", "user.run_python", "user.run_python_with_args" },
      default_detail = 3,
      task_list = {
        direction = "right",
        bindings = {
          ["o"] = "OpenFloat",
          ["O"] = "Open",
        },
      },
    },
    keys = function(_, keys)
      local new_keys = {
        { "<leader>oo", "<cmd>OverseerQuickAction open float<cr>", desc = "Open float" },
        { "<leader>or", "<cmd>OverseerQuickAction restart<cr>", desc = "Restart" },
        { "<leader>od", "<cmd>OverseerQuickAction dispose<cr>", desc = "Dispose" },
        { "<leader>oq", "<cmd>OverseerQuickAction open output in quickfix<cr>", desc = "quickfix" },
        { "<leader>oQ", "<cmd>OverseerQuickAction<cr>", desc = "Quick Action" },
        { "<leader>os", "<cmd>OverseerTaskAction<cr>", desc = "Select task action" },
        { "<leader>ol", "<cmd>OverseerToggle<cr>", desc = "Task list" },
        { "<leader>oa", "<cmd>OverseerRun<cr>", desc = "Run task" },
        { "<leader>oi", "<cmd>OverseerInfo<cr>", desc = "Overseer Info" },
        { "<leader>ob", "<cmd>OverseerBuild<cr>", desc = "Task builder" },
        { "<leader>oc", "<cmd>OverseerClearCache<cr>", desc = "Clear cache" },
        { "<leader>oD", "<cmd>OverseerDeleteBundle<cr>", desc = "Delete bundle" },
        { "<leader>oL", "<cmd>OverseerLoadBundle<cr>", desc = "Load bundle" },
      }

      return new_keys
    end,
  },
}
