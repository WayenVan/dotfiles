return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "default",
        ["<C-x>"] = { "show", "show_documentation", "hide_documentation" },
      },
      sources = {
        cmdline = { "cmdline" },
      },
    },
  },
}
