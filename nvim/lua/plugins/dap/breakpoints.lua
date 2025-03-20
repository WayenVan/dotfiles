-- #WARN: still buggy, not working as expected
return {
  {
    "Carcuis/dap-breakpoints.nvim",
    enabled = false,
    dependencies = {
      "Weissle/persistent-breakpoints.nvim",
    },
    keys = {
      {
        "<leader>d.",
        function()
          require("dap-breakpoints.api").toggle_breakpoint()
        end,
        desc = "dap breakpoints",
      },
    },
  },
  {
    "Weissle/persistent-breakpoints.nvim",
    event = "BufRead",
    enabled = false,
    config = function()
      require("persistent-breakpoints").setup({
        load_breakpoints_event = { "BufReadPost" },
      })
    end,
  },
}
