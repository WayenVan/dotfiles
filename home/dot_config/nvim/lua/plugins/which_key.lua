return {
  {
    "folke/which-key.nvim",
    lazy = false,
    keys = {
      {
        "<localleader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
    opts = {
      preset = "classic",
    },
  },
  {
    "folke/which-key.nvim",
    lazy = false,
    keys = function(_, keys)
      table.remove(keys, 1)
    end,
  },
}
