return {
  {
    "folke/flash.nvim",
    -- labels = "asdfghjklqwertyuiopzxcvbnm",
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
          jump_labels = true,
          highlight = { backdrop = true },
          label = {
            rainbow = { enabled = true },
            -- exclude = "hjkliardc"
            exclude = "hjklgyprdc"
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
