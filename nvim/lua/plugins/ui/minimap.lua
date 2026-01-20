return {
  {
    "nvim-mini/mini.map",
    lazy = false,
    enabled = true,
    version = "*",
    keys = {
      {
        "<leader>mm",
        function()
          require("mini.map").toggle()
        end,
        desc = "Toggle minimap",
      },
      {
        "<leader>mf",
        function()
          local MiniMap = require("mini.map")
          MiniMap.toggle_focus()
        end,
        desc = "Toggle focus",
      },
    },
    config = function()
      local MiniMap = require("mini.map")
      require("mini.map").setup({
        integrations = {
          MiniMap.gen_integration.builtin_search({
            search = "Search",
          }),
          MiniMap.gen_integration.gitsigns(),
          MiniMap.gen_integration.diagnostic({
            error = "DiagnosticError",
            warn = "DiagnosticWarn",
            info = "DiagnosticInfo",
            hint = "DiagnosticHint",
          }),
        },
        symbols = {
          encode = MiniMap.gen_encode_symbols.dot("4x2"),
        },
      }) -- replace {} with your config table
      -- MiniMap.config.symbols.encode = MiniMap.gen_encode_symbols.dot("3x2")
      MiniMap.config.window.width = 40
    end,
  },
}
