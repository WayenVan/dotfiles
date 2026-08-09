return {
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    opts = function()
      LazyVim.cmp.actions.snippet_backward = function()
        local ls = require("luasnip")
        if ls.jumpable(-1) then
          ls.jump(-1)
          return true
        end
        return false
      end
    end,

    config = function(_, opts)
      local ls = require("luasnip")

      -- snip jump with fallback
      -- vim.keymap.set({ "i", "s" }, "<C-k>", function()
      --   if ls.jumpable(-1) then
      --     ls.jump(-1)
      --   else
      --     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-k>", true, true, true), "n", true)
      --   end
      -- end, { silent = true, noremap = true, desc = "LusSnip jump to previous entry" })
      --
      -- vim.keymap.set({ "i", "s" }, "<C-j>", function()
      --   if ls.jumpable(1) then
      --     ls.jump(1)
      --   else
      --     vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-j>", true, true, true), "n", true)
      --   end
      -- end, { silent = true, noremap = true, desc = "LuaSnip jump to next entry" })

      ls.config.set_config(opts)

      -- import snipets
      require("plugins.cmp.snippets.lua")
    end,
  },
}
