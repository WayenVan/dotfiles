return {
  {
    "zbirenbaum/copilot.lua",
    opts = function()
      vim.keymap.set("i", "<M-w>", function()
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept_word()
        end
      end, { desc = "Accept Copilot suggestion word" })
      vim.keymap.set("i", "<M-l>", function()
        if require("copilot.suggestion").is_visible() then
          require("copilot.suggestion").accept_line()
        end
      end, { desc = "Accept Copilot suggestion line" })
    end,
  },
}
