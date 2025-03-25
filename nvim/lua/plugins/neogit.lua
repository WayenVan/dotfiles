return {
  {
    "NeogitOrg/neogit",
    lazy = true,
    cmd = {
      "Neogit",
    },
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      -- Only one of these is needed, not both.
      "ibhagwan/fzf-lua", -- optional
    },
    opts = {
      disable_signs = true,
    },
    keys = function(_, keys)
      -- NOTE: Connot override these???
      --
      -- local wk = require("which-key")
      -- wk.add({
      --   { "<leader>G", group = "git", icon = "󰊢", desc = "+git" },
      -- }, {
      --   created = true,
      -- })
      -- local log = require("plenary.log"):new()

      vim.list_extend(keys, {
        { "<leader>gg", "<cmd>Neogit<cr>", desc = "Neogit", noremap = true },
        { "<leader>gD", "<cmd>Neogit diff<cr>", desc = "Neogit Different", noremap = true },
        { "<leader>gP", "<cmd>Neogit push<cr>", desc = "Neogit push", noremap = true },
        { "<leader>gp", "<cmd>Neogit pull<cr>", desc = "Neogit pull", noremap = true },
        { "<leader>gt", "<cmd>Neogit tag<cr>", desc = "Neogit tag", noremap = true },
        { "<leader>gb", "<cmd>Neogit branch<cr>", desc = "Neogit branch", noremap = true },
      })
      return keys
    end,
    config = true,
  },
}
