-- deprecated, replace by neominimap.nvim
return {
  "echasnovski/mini.map",
  version = "*",
  enabled = false,
  event = "BufEnter",
  keys = {
    { "<leader>m", "<Nop>", desc = "+MiniMap" },
    {
      "<leader>mo",
      function()
        MiniMap.open()
      end,
    },
    {
      "<leader>mc",
      function()
        MiniMap.close()
      end,
    },
    {
      "<leader>mf",
      function()
        MiniMap.toggle_focus()
      end,
    },
    {
      "<leader>ms",
      function()
        MiniMap.toggle_side()
      end,
    },
    {
      "<leader>mm",
      function()
        MiniMap.toggle()
      end,
    },
    {
      "<leader>mr",
      function()
        MiniMap.refresh()
      end,
    },
  },
  -- No need to copy this inside `setup()`. Will be used automatically.
  opts = {
    window = {
      zindex = 1000,
      focusable = false,
    },
  },
  config = function(_, opts)
    require("mini.map").setup(opts)
  end,
}
