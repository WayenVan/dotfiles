return {
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {
      doc_lines = 0,
      border = "solid",
      transparency = 95,
      handler_opts = {
        border = "solid",
      },
      hint_enable = false,
      hint_prefix = {
        above = "↙ ", -- when the hint is on the line above the current line
        current = "← ", -- when the hint is on the same line
        below = "↖ ", -- when the hint is on the line below the current line
      },
      hi_parameter = "@markup.list.markdown",
    },
    keys = {
      {
        "<c-g>",
        function()
          require("lsp_signature").toggle_float_win()
        end,
        mode = "i",
      },
    },
    config = function(_, opts)
      require("lsp_signature").setup(opts)

      LazyVim.lsp.on_attach(function(client, buffer)
        require("lsp_signature").on_attach({
          -- hint_prefix = "🧐 ",
          bind = true,
        }, buffer)
      end)
    end,
  },
}
