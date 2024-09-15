return {
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    config = function(_, opts)
      local ls = require("luasnip")
      --   ls.expand()
      -- end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<C-k>", function()
        ls.jump(1)
      end, { silent = true, noremap = true, desc = "LusSnip jump to next entry" })
      vim.keymap.set({ "i", "s" }, "<C-j>", function()
        ls.jump(-1)
      end, { silent = true, noremap = true, desc = "LusSnip jump to prev entry" })

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

  -- LSP keymaps
  {
    "neovim/nvim-lspconfig",
    opts = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- change a keymap
      -- disable a keymap
      keys[#keys + 1] = { "<c-k>", false, mode = "i" }
    end,
  },
}
