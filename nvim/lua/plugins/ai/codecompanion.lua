local deepseek_api_key = vim.env.LLM_KEY
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    cmd = { "CodeCompanion" },
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
      {
        "<leader>ai",
        function()
          local input = vim.fn.input("Prompt")
          require("codecompanion").inline({ args = input })
        end,
        mode = { "v", "n" },
        desc = "Codecompanion inline ",
      },
      {
        "<leader>aT",
        function()
          require("codecompanion").prompt("trans")
        end,
        desc = "Prompt translate",
      },
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
        prompt_library = {
          ["translate"] = {
            strategy = "chat",
            description = "Trnaslate Chinese to English",
            opts = {
              index = 11,
              is_slash_cmd = false,
              auto_submit = false,
              short_name = "trans",
              ignore_system_prompt = true,
              adapter = {
                name = "deepseek",
                model = "deepseek-chat",
              },
            },
            prompts = {
              {
                role = "system",
                -- append to the system prompt
                content = "You are now actin as a good Chinese to English translator named Bob",
              },
              {
                role = "user",
                content = "First, tellme who you are, then can you translate this for me?",
              },
            },
          },
        },
      })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "codecompanion",
        callback = function(ev)
          vim.keymap.set("n", "q", function()
            require("codecompanion").toggle()
          end, { buffer = true })
        end,
      })
    end,
  },
}
