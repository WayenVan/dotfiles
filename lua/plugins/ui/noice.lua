return {
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.lsp.signature = {
        enabled = false,
      }
    end,
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
    { "<leader>n", "", desc = "+noice/neoconfig"},
    { "<leader>nc", "", desc = "+noice"},
    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    { "<leader>ncl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    { "<leader>nch", function() require("noice").cmd("history") end, desc = "Noice History" },
    { "<leader>nca", function() require("noice").cmd("all") end, desc = "Noice All" },
    { "<leader>ncd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    { "<leader>ncs", function() require("noice").cmd("pick") end, desc = "Noice Picker (Telescope/FzfLua)" },
    { "<c-f>", function() if not require("noice.lsp").scroll(4) then return "<c-f>" end end, silent = true, expr = true, desc = "Scroll Forward", mode = {"i", "n", "s"} },
    { "<c-b>", function() if not require("noice.lsp").scroll(-4) then return "<c-b>" end end, silent = true, expr = true, desc = "Scroll Backward", mode = {"i", "n", "s"}},
  },
  },
}
