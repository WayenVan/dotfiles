local build_command = "make"
local os, arch = require("utils.os_name").get_os_name()
if os == "Windows" then
  build_command = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
end
return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      provider = "copilot",
      -- add any opts here
      windows = {
        width = 35,
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false", -- for windows
    keys = {
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
    },
    build = build_command,
    config = function(_, opts)
      require("avante_lib").load()
      require("avante").setup(opts)

      -- setup auto command for avante buffer
      vim.api.nvim_create_augroup("Avante_", { clear = true })
      vim.api.nvim_create_autocmd({ "FileType" }, {
        group = "Avante_",
        pattern = { "Avante", "AvanteInput" },
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          vim.api.nvim_buf_set_keymap(buf, "n", "q", "<CMD>AvanteToggle<CR>", { noremap = true, silent = true })
        end,
      })
    end,
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "Avante" },
        },
        ft = { "Avante" },
      },
    },
  },
}