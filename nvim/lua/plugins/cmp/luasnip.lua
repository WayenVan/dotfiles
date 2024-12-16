return {
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    config = function(_, opts)
      local ls = require("luasnip")
      -- --   ls.expand()
      -- -- end, { silent = true })
      -- vim.keymap.set({ "i", "s" }, "<C-k>", function()
      --   ls.jump(-1)
      -- end, { silent = true, noremap = true, desc = "LusSnip jump to previous entry" })
      -- vim.keymap.set({ "i", "s" }, "<C-j>", function()
      --   ls.jump(1)
      -- end, { silent = true, noremap = true, desc = "LuaSnip jump to next entry" })

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
}
