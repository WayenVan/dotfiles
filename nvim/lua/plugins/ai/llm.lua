return {
  {
    "Kurama622/llm.nvim",
    enabled = false,
    dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
    cmd = { "LLMSessionToggle", "LLMSelectedTextHandler", "LLMAppHandler" },
    keys = {
      { "<leader>A", mode = "n", "<cmd>LLMSessionToggle<cr>" },
    },
    config = function()
      require("llm").setup({
        -- [[ Deepseek ]]
        url = "https://api.deepseek.com/chat/completions",
        model = "deepseek-chat",
        api_type = "openai",
        max_tokens = 4096,
        temperature = 0.3,
        top_p = 0.7,

        prompt = "You are a helpful assistant.",

        prefix = {
          user = { text = "😃 ", hl = "Title" },
          assistant = { text = "  ", hl = "Added" },
        },

        -- history_path = "/tmp/llm-history",
        save_session = true,
        max_history = 15,
        max_history_name_length = 20,

        -- stylua: ignore
        keys = {
          -- The keyboard mapping for the input window.
          ["Input:Submit"]      = { mode = "n", key = "<cr>" },
          ["Input:Cancel"]      = { mode = {"n", "i"}, key = "<C-c>" },
          ["Input:Resend"]      = { mode = {"n", "i"}, key = "<C-r>" },

          -- only works when "save_session = true"
          ["Input:HistoryNext"] = { mode = {"n", "i"}, key = "<C-n>" },
          ["Input:HistoryPrev"] = { mode = {"n", "i"}, key = "<C-p>" },

          -- The keyboard mapping for the output window in "split" style.
          ["Output:Ask"]        = { mode = "n", key = "i" },
          ["Output:Cancel"]     = { mode = "n", key = "<C-c>" },
          ["Output:Resend"]     = { mode = "n", key = "<C-r>" },

          -- The keyboard mapping for the output and input windows in "float" style.
          ["Session:Toggle"]    = { mode = "n", key = {"<leader>A"} },
          ["Session:Close"]     = { mode = "n", key = {"q", "<esc>"} },

          -- Switch from the output window to the input window.
          ["Focus:Input"]       = { mode = "n", key = {"i", "<C-w>", "<C-j>"} },
          -- Switch from the input window to the output window.
          ["Focus:Output"]      = { mode = { "n", "i" }, key = {"<C-w>", "<C-k>" }},
        },

        chat_ui_opts = {
          output = {
            float = {
              win_options = {
                number = true,
                relativenumber = true,
              },
            },
          },
        },
      })
    end,
  },
}
