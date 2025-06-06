return {
  {
    "leath-dub/snipe.nvim",
    event = "BufRead",
    keys = {
      {
        "<leader>,",
        function()
          require("snipe").open_buffer_menu()
        end,
        desc = "Open Snipe buffer menu",
      },
    },
    opts = {
      hints = {
        dictionary = "adflewcmpghio",
      },
      ui = {
        preselect_current = true,
        position = "center",
      },
      navigate = {
        -- cancel_snipe = "q",
      },
      sort = "last",
    },
    config = function(_, opts)
      require("snipe").setup(opts)
      vim.api.nvim_create_autocmd({ "Filetype" }, {
        pattern = { "snipe-menu" },
        callback = function(ev)
          vim.keymap.set("n", "q", "<cmd>q<cr>", { buffer = ev.buf, nowait = true })
        end,
      })
    end,
  },
  {
    "nicholasxjy/snipe-marks.nvim",
    dependencies = { "leath-dub/snipe.nvim" },
    keys = {
      {
        "<leader>'",
        function()
          require("snipe-marks").open_marks_menu()
        end,
        desc = "Find local marks",
      },
      {
        "<leader>@",
        function()
          require("snipe-marks").open_marks_menu("all")
        end,
        desc = "Find all marks",
      },
      {
        '<leader>"',
        function()
          require("snipe-marks").open_marks_menu("all")
        end,
        desc = "Find all marks",
      },
    },
  },
}
