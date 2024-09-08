return {
  {
    "stevearc/oil.nvim",
    ---@module 'oil'
    ---@type oil.SetupOpts
    opts = {
      skip_confirm_for_simple_edits = true,
      win_options = {
        wrap = true,
      },
      delete_to_trash = true,
      keymaps = {
        ["<C-h>"] = false,
        ["<C-l>"] = false,
        ["<C-v>"] = false,
        ["<C-s>"] = false,
        ["<localleader>s"] = {
          "actions.select",
          opts = { horizontal = true },
          desc = "Oil: Open horizontal split",
        },
        ["<localleader>v"] = {
          "actions.select",
          opts = { vertical = true },
          desc = "Oil: Open vertical split",
        },
        ["<localleader>r"] = { "actions.refresh", desc = "Oil: refresh" },
        ["q"] = "actions.close",
      },
    },
    -- Optional dependencies
    -- dependencies = { { "echasnovski/mini.icons", opts = {} } },
    -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    dependencies = { "DaikyXendo/nvim-material-icon" }, -- use if prefer nvim-web-dev
    keys = {
      {
        "_",
        function()
          vim.cmd("Oil " .. vim.uv.cwd())
        end,
        desc = "Open Oil (Directory of Current File)",
      },
      {
        "-",
        function()
          -- require("mini.files").open(vim.uv.cwd(), true)
          vim.cmd("Oil")
        end,
        desc = "Open Oil (cwd)",
      },
      {
        "<leader>-",
        function()
          -- require("mini.files").open(vim.uv.cwd(), true)
          require("oil").toggle_float()
        end,
        desc = "Open Oil (cwd)",
      },
    },
  },
}
