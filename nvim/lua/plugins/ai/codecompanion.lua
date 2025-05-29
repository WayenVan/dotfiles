local deepseek_api_key = vim.env.DEEPSEEK_API_KEY
return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "MeanderingProgrammer/render-markdown.nvim",
    },
    cmd = { "CodeCompanion", "CodeCompanionAction" },
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
        "<leader>as",
        function()
          require("codecompanion").prompt("ask")
        end,
        desc = "Create new chat",
      },
      {
        "<leader>ai",
        function()
          vim.ui.input({ prompt = "Prompt: " }, function(input)
            if not input or input == "" then
              return
            end
            vim.cmd("normal! gv")
            require("codecompanion").inline({ args = input })
          end)
        end,
        mode = { "v" },
        desc = "Codecompanion inline ",
      },
      {
        "<leader>ai",
        "<cmd>CodeCompanion<cr>",
        mode = { "n" },
        desc = "Codecompanion inline",
      },
      {
        "<leader>ac",
        "<cmd>CodeCompanionAction<cr>",
        desc = "Toggle codecompanion",
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
            adapter = "deepseek",
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
                  default = "claude-3.7-sonnet",
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
          ["Pharaphrase"] = {
            strategy = "chat",
            description = "paraphrase academic text",
            opts = {
              index = 1,
              is_slash_cmd = false,
              auto_submit = true,
              short_name = "phrase",
              ignore_system_prompt = true,
              adapter = {
                name = "deepseek",
                model = "deepseek-reasoner",
              },
            },
            prompts = {
              {
                role = "system",
                -- append to the system prompt
                content = [[
                **Task:**  
                1. **Paraphrase** the following academic text in a paper while preserving its original meaning, formal tone, and key terminology.  
                2. **Analyze and suggest improvements** for:  
                  - Clarity & conciseness (wordiness, ambiguity, readability).  
                  - Logical flow (gaps in reasoning, weak transitions, unsupported claims).  
                  - Argument strength (evidence linkage, premise-conclusion coherence, counterarguments).  
                  - Structural coherence (paragraph organization, thesis alignment).  
                  - Avoid using too much listing format.
              **Instructions:**  
              - **Paraphrased Version:** Provide a polished rewrite that avoids plagiarism but retains scholarly precision. Highlight major changes.  
              - **Critical Feedback:**  
                - **Logic & Reasoning:** Identify leaps in logic, circular arguments, or underdeveloped points. Suggest fixes (e.g., stronger evidence, clearer causality).  
                - **Structure:** Flag disjointed transitions or misaligned ideas. Recommend reordering or connective phrases.  
                - **Clarity:** Note jargon, passive voice overuse, or convoluted sentences. Offer simpler alternatives.  
                - **Other Improvements:** Redundancies, citation issues, or tone inconsistencies.  
                ]],
              },
              {
                role = "user",
                content = "First, tell me who you are, Then do the job of the following content",
              },
            },
          },
          ["Translate"] = {
            strategy = "chat",
            description = "Trnaslate Chinese to English",
            opts = {
              index = 1,
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
          ["General ask"] = {
            strategy = "chat",
            description = "Asking genral questions",
            opts = {
              index = 0,
              is_slash_cmd = false,
              auto_submit = false,
              short_name = "ask",
              ignore_system_prompt = true,
              adapter = {
                name = "deepseek",
                model = "deepseek-chat",
              },
            },
            prompts = {
              {
                role = "user",
                content = [[]],
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
