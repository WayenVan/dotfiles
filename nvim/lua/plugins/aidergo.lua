return {

  -- {
  --   "aidergo",
  --   dir = "~/test_plugin",
  --   lazy = false,
  --   config = function()
  --     require("aidergo").setup({
  --       default_direction = "vertical",
  --     })
  --   end,
  -- },
  --
  {
    -- "aidergo",
    "WayenVan/aidergo.nvim",
    enabled = false,
    dependencies = {
      "folke/snacks.nvim",
    },
    -- lazy = false,
    -- dir = "~/Desktop/aidergo.nvim",
    keys = {
      {
        "<leader>a/",
        function()
          require("aidergo.api").toggle()
        end,
        desc = "Toggle AiderGo",
      },
      {
        "<leader>a+",
        function()
          require("aidergo.api").add_current_file()
        end,
        desc = "Add file to AiderGo",
      },
      {
        "<leader>a-",
        function()
          require("aidergo.api").remove_current_file()
        end,
        desc = "Remove file from AiderGo",
      },
    },
    ---@type AiderGoOpt
    opts = {
      position = "right",
      width = 0.4, -- 40% of window width for vertical split
      args = {
        "--pretty",
        "--stream",
        "--no-auto-commits",
        "--watch",
        "--architect",
        "--no-auto-accept-architect",
        "--model",
        "r1",
        "--editor-model",
        "deepseek/deepseek-chat",
      },
    },
    config = function(_, opts)
      require("aidergo").setup(opts)
    end,
  },
}
