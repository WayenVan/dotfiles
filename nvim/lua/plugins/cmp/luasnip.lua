return {
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    config = function(_, opts)
      local ls = require("luasnip")
      -- vim.keymap.set({ "i" }, "<C-I>", function()
      --   ls.expand()
      -- end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-L>", function()
        ls.jump(1)
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-H>", function()
        ls.jump(-1)
      end, { silent = true })

      -- vim.keymap.set({ "i", "s" }, "<C-E>", function()
      --   if ls.choice_active() then
      --     ls.change_choice(1)
      --   end
      -- end, { silent = true })
      ls.config.set_config(opts)

      -- import snipets
      require("plugins.cmp.snippets.lua")
    end,
  },
  -- disable lazynvim cmp key settings
  {
    "nvim-cmp",
    -- stylua: ignore
    keys = {
      { "<tab>",   false },
      { "<tab>",   false },
      { "<s-tab>", false },
    },
  },
}
