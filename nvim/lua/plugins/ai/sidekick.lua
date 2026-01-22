return {
  {
    "folke/sidekick.nvim",
    lazy = false,
    keys = function()
      return {
        -- nes is also useful in normal mode
        { "<tab>", LazyVim.cmp.map({ "ai_nes" }, "<tab>"), mode = { "n" }, expr = true },
        { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
        -- {
        --   "<leader>a/",
        --   function()
        --     require("sidekick.cli").toggle()
        --   end,
        --   mode = { "n" },
        --   desc = "Sidekick Toggle",
        -- },
      }
    end,
  },
}
