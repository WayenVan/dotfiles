return {
  {
    "yetone/avante.nvim",
    -- event = "VeryLazy",
    enabled = true,
    opts = {
      mappings = {
        files = {
          add_current = "<leader>A+",
          add_all_buffers = "<leader>AB",
        },
      },
      hints = { enabled = false },
      -- add any opts here
      windows = {
        width = 35,
        ask = {
          start_insert = false,
        },
      },

      behaviour = {
        auto_set_keymaps = false,
      },
      instructions_file = "avante.md",
      -- for example
      -- mode = "agentic",
      -- provider = "hermes",
      provider = "deepseek",
      providers = {
        deepseek = {
          __inherited_from = "openai",
          api_key_name = "DEEPSEEK_API_KEY",
          endpoint = "https://api.deepseek.com/",
          model = "deepseek-v4-flash",
          extra_request_body = {
            max_tokens = 393216,
            thinking = { type = "enabled" },
          },
        },
      },
      acp_providers = {
        hermes = {
          command = "hermes",
          args = { "acp" },

          env = {
            HOME = vim.env.HOME,
            PATH = vim.env.PATH,
          },
        },
        codex = {
          command = "codex-acp",
          args = {},

          env = {
            HOME = os.getenv("HOME"),
            PATH = os.getenv("PATH"),
            NODE_NO_WARNINGS = "1",

            -- 使用 ChatGPT Plus 登录时不要在这里传 API key
            -- OPENAI_API_KEY = os.getenv("OPENAI_API_KEY"),
          },
        },
      },

      -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
      -- build = "make",
      -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false", -- for windows
    },
    keys = {

      {
        "<leader>AA",
        "<CMD>AvanteToggle<CR>",
        desc = "Toggle Avante",
      },
      {
        "<leader>A",
        "",
        desc = "+ Avante",
      },
    },
    build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    config = function(_, opts)
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

      --automatic refresh when enter thing in
      vim.api.nvim_create_autocmd({ "InsertEnter" }, {
        group = "Avante_",
        callback = function()
          local pattern = { "AvanteInput" }
          if not vim.tbl_contains(pattern, vim.bo.filetype) then
            return
          end
          vim.cmd("AvanteRefresh")
          -- vim.notify("refresh")
        end,
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "DaikyXendo/nvim-material-icon",
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      "folke/snacks.nvim", -- for input provider snacks
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
        -- opts = {
        --   file_types = { "Avante" },
        -- },
        -- ft = { "Avante" },
      },
    },
  },
}
