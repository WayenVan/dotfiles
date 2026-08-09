return {
  {
    "BibekBhusal0/bufstack.nvim",
    -- still snipe is bettter
    enabled = false,
    dependencies = { "MunifTanjim/nui.nvim" }, -- required if you want to use menu
    opts = { max_tracked = 16 },
  },
  {
    "bloznelis/buftrack.nvim",
    enabled = false,
    config = function()
      local buftrack = require("buftrack")
      buftrack.setup()

      -- Not required but recommended. Once you start inserting text,
      -- this will move the current buffer to the top of the tracklist.
      vim.api.nvim_create_autocmd({ "InsertEnter" }, {
        callback = buftrack.track_buffer,
      })

      -- vim.keymap.set("n", "<C-j>", buftrack.prev_buffer)
      -- vim.keymap.set("n", "<C-k>", buftrack.next_buffer)
    end,
  },
}
