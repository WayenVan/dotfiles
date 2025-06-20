-- Lua
return {
  {
    "abecodes/tabout.nvim",
    enabled = false, -- Set to false to disable the plugin
    config = function()
      require("tabout").setup({
        -- tabkey = "<c-l>", -- key to trigger tabout, set to an empty string to disable
        -- backwards_tabkey = "<c-h>", -- key to trigger backwards tabout, set to an empty string to disable
        tabkey = "<Tab>",
        backwards_tabkey = "<S-Tab>",
        act_as_tab = true, -- shift content if tab out is not possible
        act_as_shift_tab = true, -- reverse shift content if tab out is not possible (if your keyboard/terminal supports <S-Tab>)
        -- default_tab = "<C-t>", -- shift default action (only at the beginning of a line, otherwise <TAB> is used)
        -- default_shift_tab = "<C-d>", -- reverse shift default action,
        enable_backwards = true, -- well ...
        completion = false, -- if the tabkey is used in a completion pum
        tabouts = {
          { open = "", close = "'" },
          { open = '"', close = '"' },
          { open = "`", close = "`" },
          { open = "(", close = ")" },
          { open = "[", close = "]" },
          { open = "{", close = "}" },
          { open = "<", close = ">" },
        },
        ignore_beginning = true, --[[ if the cursor is at the beginning of a filled element it will rather tab out than shift the content ]]
        exclude = {}, -- tabout will ignore these filetypes
      })
    end,
    dependencies = { -- These are optional
      "nvim-treesitter/nvim-treesitter",
      "L3MON4D3/LuaSnip",
    },
    opt = true, -- Set this to true if the plugin is optional
    event = "InsertEnter", -- Set the event to 'InsertCharPre' for better compatibility
    priority = 1000,
  },
}
