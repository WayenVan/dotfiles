return {
  "Vonr/align.nvim",
  lazy = true,
  enabled = false,
  keys = {
    { mode = "x", "ga", "", desc = "go align" },
    {
      mode = "x",
      "gaa",
      function()
        require("align").align_to_char({
          length = 1,
        })
      end,
      desc = "Aligns to 1 char",
    },
    {
      mode = "x",
      "gad",
      function()
        require("align").align_to_char({
          preview = true,
          length = 2,
        })
      end,
      desc = "Aligns to 2 chars",
    },
    {
      mode = "x",
      "gas",
      function()
        require("align").align_to_string({
          preview = true,
          regex = false,
        })
      end,
      desc = "Aligns to string",
    },
    {
      mode = "x",
      "gar",
      function()
        require("align").align_to_string({
          preview = true,
          regex = true,
        })
      end,
      desc = "Aligns to Vim regex",
    },
  },
}
