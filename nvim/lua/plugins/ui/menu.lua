return {
  {
    "nvchad/menu",
    lazy = true,
    keys = {
      {
        "<localleader><localleader>",
        function()
          require("menu").open("default", { border = true })
        end,
        desc = "open menu",
      },
      {
        "<RightMouse>",
        function()
          require("menu").open("default", { border = true })
        end,
        desc = "open menu",
      },
    },
  },
}
