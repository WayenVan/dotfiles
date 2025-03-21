local deepseek_api_key = vim.env.LLM_KEY
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmds = { "Codecompanion" },
    keys = {
      { "<leader>a", "", desc = "+ai" },
      {
        "<leader>aa",
        function()
          require("codecompanion").toggle()
        end,
        desc = "Toggle codecompanion",
      },
      {
        "<leader>an",
        function()
          require("codecompanion").chat()
        end,
        desc = "Create new chat",
      },
      -- {
      --   "<leader>ai",
      --   "<cmd>'<,'>CodeCompanion<CR>",
      --   mode = "v",
      --   desc = "Codecompanion inline ",
      -- },
    },
    config = function()
      require("codecompanion").setup({
        strategies = {
          chat = {
            adapter = "copilot",
            keymaps = {
              close = {
                modes = { n = "Q", i = "<C-q>" },
              },
              stop = {
                modes = { n = "<C-c>", i = "<C-c>" },
              },
            },
          },
        },
        adapters = {
          copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
              schema = {
                model = {
                  default = "gpt-4o",
                },
              },
            })
          end,
          deepseek = function()
            return require("codecompanion.adapters").extend("deepseek", {
              env = {
                api_key = deepseek_api_key,
              },
              schema = {
                model = {
                  default = "deepseek-chat",
                },
              },
            })
          end,
        },
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "codecompanion",
        callback = function(ev)
          vim.keymap.set("n", "q", "<cmd>q<CR>", { buffer = true })
        end,
      })
    end,
  },
}
