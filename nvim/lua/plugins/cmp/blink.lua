return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "default",
        ["<C-x>"] = { "show", "show_documentation", "hide_documentation" },
      },
      -- cmdline = {
      --   enabled = true,
      --   completion = {
      --     menu = { auto_show = true },
      --   },
      -- },
    },
  },
}
