return {
  {
    "bloznelis/before.nvim",
    event = "BufEnter",

    keys = {
      {
        "<leader>'",
        function()
          require("before").show_edits_in_quickfix()
        end,
        desc = "Show edits in quickfix",
      },
      {
        "<c-n>",
        function()
          require("before").jump_to_next_edit()
        end,
      },
      {
        "<c-p>",
        function()
          require("before").jump_to_last_edit()
        end,
      },
    },
    config = function()
      local before = require("before")
      before.setup()

      -- Jump to previous entry in the edit history
      -- vim.keymap.set("n", "<C-h>", before.jump_to_last_edit, {})
      --
      -- -- Jump to next entry in the edit history
      -- vim.keymap.set("n", "<C-l>", before.jump_to_next_edit, {})
      --
      -- -- Look for previous edits in quickfix list
      -- vim.keymap.set("n", "<leader>oq", before.show_edits_in_quickfix, {})
      -- -- Look for previous edits in location list
      --
      -- -- Look for previous edits in telescope (needs telescope, obviously)
      -- vim.keymap.set("n", "<leader>oe", before.show_edits_in_telescope, {})
    end,
  },
}
