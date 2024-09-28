return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {
      modes = {
        search = {
          multi_window = false,
          highlight = { backdrop = true },
          label = {
            rainbow = { enabled = true },
          },
        },
        char = {
          jump_labels = true,
          -- highlight = { backdrop = true },
          -- multi_line = false,
          label = {
            rainbow = { enabled = true },
            -- exclude = "hjkliardc"
            exclude = "hjklvgyYrdc",
          },
        },
        treesitter = {
          label = {
            style = "overlay",
            rainbow = { enabled = true },
          },
        },
      },
    },
    -- stylua: ignore
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump({
            multi_window = false,
            highlight = { backdrop = true },
            label = {
              rainbow = { enabled = true }
            }
          })
        end,
        desc = "Flash"
      },
      {
        "S",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter"
      },
      { "r",     mode = "o",          function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },      function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
}
