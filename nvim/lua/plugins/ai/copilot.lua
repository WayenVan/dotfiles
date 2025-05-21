return {
  {
    "zbirenbaum/copilot.lua",
    event = "VeryLazy",
    opts = {
      copilot_model = "gpt-4o-copilot",
      suggestion = {
        enabled = true,
        keymap = {
          accept = "<M-a>",
          accept_word = "<M-w>",
          accept_line = "<M-l>",
        },
      },
    },
  },
}
