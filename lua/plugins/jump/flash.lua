return {
  {
    "folke/flash.nvim",
    ---@type Flash.Config
    opts = {
      label = {
        rainbow = { enabled = true },
      },
      modes = {
        search = {
          highlight = { backdrop = true },
          label = {
            rainbow = { enabled = true },
          },
        },
        char = {
          jump_labels = false,
          highlight = { backdrop = true },
          label = {
            rainbow = { enabled = true },
          },
        },
        treesitter = {
          label = {
            rainbow = { enabled = true },
          },
        },
      },
    },
  },
}
