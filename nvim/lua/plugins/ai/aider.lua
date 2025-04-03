local bright_theme = {
  user_input_color = "#000fff",
  tool_output_color = "FF6600",
  tool_error_color = "#ed8796",
  tool_warning_color = "#eed49f",
  assistant_output_color = "#c6a0f6",
  completion_menu_color = "#cad3f5",
  completion_menu_bg_color = "#24273a",
  completion_menu_current_color = "#181926",
  completion_menu_current_bg_color = "#f4dbd6",
}
local default_theme = {
  user_input_color = "#a6da95",
  tool_output_color = "#8aadf4",
  tool_error_color = "#ed8796",
  tool_warning_color = "#eed49f",
  assistant_output_color = "#c6a0f6",
  completion_menu_color = "#cad3f5",
  completion_menu_bg_color = "#24273a",
  completion_menu_current_color = "#181926",
  completion_menu_current_bg_color = "#f4dbd6",
}
return {
  {
    "GeorgesAlkhouri/nvim-aider",
    enabled = false,
    cmd = {
      "AiderTerminalToggle",
      "AiderHealth",
    },
    keys = {
      { "<leader>a/", "<cmd>AiderTerminalToggle<cr>", desc = "Open Aider" },
      -- { "<leader>as", "<cmd>AiderTerminalSend<cr>", desc = "Send to Aider", mode = { "n", "v" } },
      -- { "<leader>ac", "<cmd>AiderQuickSendCommand<cr>", desc = "Send Command To Aider" },
      -- { "<leader>ab", "<cmd>AiderQuickSendBuffer<cr>", desc = "Send Buffer To Aider" },
      { "<leader>a+", "<cmd>AiderQuickAddFile<cr>", desc = "Add File to Aider" },
      { "<leader>a-", "<cmd>AiderQuickDropFile<cr>", desc = "Drop File from Aider" },
      -- { "<leader>ar", "<cmd>AiderQuickReadOnlyFile<cr>", desc = "Add File as Read-Only" },
      -- Example nvim-tree.lua integration if needed
      { "<leader>a+", "<cmd>AiderTreeAddFile<cr>", desc = "Add File from Tree to Aider", ft = "NvimTree" },
      { "<leader>a-", "<cmd>AiderTreeDropFile<cr>", desc = "Drop File from Tree from Aider", ft = "NvimTree" },
    },
    opts = function(_, opts)
      if vim.o.background == "light" then
        opts.theme = vim.deepcopy(bright_theme)
      end
    end,
    dependencies = {
      "folke/snacks.nvim",
      --- Neo-tree integration
      {
        "nvim-neo-tree/neo-tree.nvim",
        opts = function(_, opts)
          -- Example mapping configuration (already set by default)
          -- opts.window = {
          --   mappings = {
          --     ["+"] = { "nvim_aider_add", desc = "add to aider" },
          --     ["-"] = { "nvim_aider_drop", desc = "drop from aider" }
          --   }
          -- }
          require("nvim_aider.neo_tree").setup(opts)
        end,
      },
    },
    config = function(_, opts)
      require("nvim_aider").setup(opts)
      -- local aider_group = vim.api.nvim_create_augroup("Aider", { clear = true })
      -- vim.api.nvim_create_autocmd("OptionSet", {
      --   group = aider_group,
      --   pattern = "background",
      --   callback = function()
      --     local cfg = require("nvim_aider.config")
      --     if vim.o.background == "light" then
      --       cfg.theme = bright_theme
      --     else
      --       cfg.theme = default_theme
      --     end
      --     vim.notify(vim.inspect(cfg.theme), vim.log.levels.INFO, {
      --       title = "Aider Theme",
      --       timeout = 2000,
      --     })
      --   end,
      -- })
    end,
  },
}
