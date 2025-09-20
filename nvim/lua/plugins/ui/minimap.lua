return {
  {
    "nvim-mini/mini.map",
    lazy = false,
    enabled = false,
    version = "*",
    keys = {
      {
        "<leader>;;",
        function()
          MiniMap.toggle()
        end,
        desc = "Toggle minimap",
      },
      {
        "<leader>;f",
        function()
          MiniMap.toggle_focus()
        end,
        desc = "Toggle focus",
      },
    },
    config = function()
      require("mini.map").setup({}) -- replace {} with your config table
      MiniMap.config.symbols.encode = MiniMap.gen_encode_symbols.dot("3x2")
      MiniMap.config.window.width = 40
    end,
  },
}
