return {
  {
    "jbyuki/venn.nvim",
    lazy = true,
    keys = function(_, keys)
      -- set
      -- LazyVim.toggle.map(
      --   "<leader>D",
      --   LazyVim.toggle.wrap({
      --     name = "toggle venn drawing",
      --     get = function()
      --       if vim.b.venn_enabled then
      --         return true
      --       else
      --         return false
      --       end
      --     end,
      --     set = function(state)
      --       require("utils.draw").Toggle_venn()
      --     end,
      --   })
      -- )
      return keys
    end,
    cmd = { "VBox" },
  },
}
