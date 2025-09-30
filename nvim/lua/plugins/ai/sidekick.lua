return {
  {
    "folke/sidekick.nvim",
    keys = function()
      return {
        -- nes is also useful in normal mode
        { "<tab>", LazyVim.cmp.map({ "ai_nes" }, "<tab>"), mode = { "n" }, expr = true },
        { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
        {
          "<leader>a/",
          function()
            require("sidekick.cli").toggle()
          end,
          mode = { "n" },
          desc = "Sidekick Toggle",
        },
        {
          "<leader>an",
          function()
            require("sidekick.cli").select_tool()
          end,
          mode = { "n" },
          desc = "Sidekick New Tool",
        },
        {
          "<c-.>",
          function()
            require("sidekick.cli").focus()
          end,
          mode = { "n", "x", "i", "t" },
          desc = "Sidekick Switch Focus",
        },
        {
          "<leader>ap",
          function()
            require("sidekick.cli").select_prompt()
          end,
          desc = "Sidekick Ask Prompt",
          mode = { "n", "v" },
        },
      }
    end,
  },
}
