return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    tag = "v4.4.7",
    opts = {
      cmdline = {
        enabled = true,
      },
      lsp = {
        signature = {
          enabled = false,
        },
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = false, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    },
    -- opts = function(_, opts)
    --   opts.lsp.signature = {
    --     enabled = false,
    --   }
    --   return {}
    -- end,
  -- stylua: ignore
  keys = {
    { "<leader>sn", false},
    { "<S-Enter>", false},
    { "<leader>snl", false},
    { "<leader>snh", false},
    { "<leader>sna", false},
    { "<leader>snd", false},
    { "<leader>snt", false},
    { "<c-f>", false},
    { "<c-b>", false},
    { "<leader>ns", "", desc = "+noice"},
    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    { "<leader>nsl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    { "<leader>nsh", function() require("noice").cmd("history") end, desc = "Noice History" },
    { "<leader>nsa", function() require("noice").cmd("all") end, desc = "Noice All" },
    { "<leader>nsd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    { "<leader>nss", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
    { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
    { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
  },
  },
}
