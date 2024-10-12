return {
  {
    "nvchad/menu",
    lazy = true,
    keys = {
      {
        "<localleader><localleader>",
        function()
          require("menu").open("common", { border = true })
        end,
        desc = "open menu",
      },
      {
        "<RightMouse>",
        function()
          require("menu").open("common", { border = true })
        end,
        desc = "open menu",
      },
    },
  },
}
