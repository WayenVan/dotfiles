return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "MeanderingProgrammer/render-markdown.nvim",
      -- "ravitemer/mcphub.nvim",
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
          require("codecompanion").prompt("General")
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
      -- {
      --   "<leader>ap",
      --   function()
      --     local cfg = require("codecompanion.config")
      --     local item = {}
      --     for k, v in pairs(cfg.prompt_library) do
      --       table.insert(item, v.opts.short_name)
      --     end
      --     table.sort(item) -- Sort the item alphabetically
      --     vim.ui.select(item, {
      --       prompt = "Select prompt",
      --     }, function(selection)
      --       if selection == nil then
      --         return
      --       end
      --       require("codecompanion").prompt(selection)
      --     end)
      --   end,
      --   desc = "Prompt translate",
      -- },
    },

    config = function()
      require("codecompanion").setup({
        extensions = {
          -- mcphub = {
          --   callback = "mcphub.extensions.codecompanion",
          --   opts = {
          --     -- MCP Tools
          --     make_tools = true, -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
          --     show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
          --     add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
          --     show_result_in_chat = true, -- Show tool results directly in chat buffer
          --     format_tool = nil, -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
          --     -- MCP Resources
          --     make_vars = true, -- Convert MCP resources to #variables for prompts
          --     -- MCP Prompts
          --     make_slash_commands = true, -- Add MCP prompts as /slash commands
          --   },
          -- },
        },
        interactions = {
          inline = {
            adapter = {
              name = "deepseek",
              model = "deepseek-v4-flash",
            },
          },
          chat = {
            adapter = {
              name = "deepseek",
              model = "deepseek-v4-flash",
            },
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
        display = {
          chat = {
            window = {
              width = 0.35,
            },
          },
          action_palette = {
            width = 95,
            height = 10,
            prompt = "Prompt ", -- Prompt used for interactive LLM calls
            provider = "default", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
            opts = {
              show_preset_actions = true, -- Show the preset actions in the action palette?
              show_preset_prompts = true, -- Show the preset prompts in the action palette?
              title = "CodeCompanion actions", -- The title of the action palette
            },
          },
        },
        prompt_library = {
          markdown = {
            dirs = {
              vim.fn.stdpath("config") .. "/prompts",
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
