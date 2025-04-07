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
        desc = "AiderGo",
      },
      {
        "<leader>a+",
        function()
          require("aidergo.api").add_current_file()
        end,
        desc = "AiderGo",
      },
      {
        "<leader>a-",
        function()
          require("aidergo.api").remove_current_file()
        end,
        desc = "AiderGo",
      },
    },
    ---@type AiderGoOpt
    opts = {
      position = "right", -- The position of the terminal, defaults to bottom
      args = {
        "--watch",
        -- "--no-prompt",
        "--architect",
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
