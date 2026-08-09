return {
  {
    "nvchad/menu",
    lazy = true,
    keys = {
      {
        "<localleader><localleader>",
        function()
          if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "" then
            require("menu").open("common", { border = true })
          end
        end,
        desc = "open menu",
      },
      -- {
      --   -- remove previous mouse mapping
      --   "<RightMouse>",
      --   function()
      --     -- only if buffer is a file buffer
      --     if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "" then
      --       require("menu").open("common", { mouse = true, border = true })
      --     end
      --   end,
      --
      --   desc = "open menu",
      -- },
    },
  },
}
