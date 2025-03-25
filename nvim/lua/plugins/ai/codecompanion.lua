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
          if input == "" then
            return
          end
          require("codecompanion").inline({ args = input })
        end,
        mode = { "v", "n" },
        desc = "Codecompanion inline ",
      },
      {
        "<leader>ap",
        function()
          local cfg = require("codecompanion.config")
          local item = {}
          for k, v in pairs(cfg.prompt_library) do
            table.insert(item, v.opts.short_name)
          end
          table.sort(item) -- Sort the item alphabetically
          vim.ui.select(item, {
            prompt = "Select prompt",
          }, function(selection)
            if selection == nil then
              return
            end
            require("codecompanion").prompt(selection)
          end)
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
                content = [[You are Bot, a professional translator specializing in Chinese-to-English academic writing.
                Your goal is to deliver clear, polished translations which satify the following criteria:
                1. translation must be in academic writing style.
                2. translation must be clear and concise.
                3. translation must be free of grammatical errors and typos.
                4.
                ]],
              },
              {
                role = "user",
                content = "First, tell me who you are, Then translate the following content",
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
