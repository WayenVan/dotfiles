return {
  {
    "ray-x/lsp_signature.nvim",
    event = "LazyFile",
    opts = {
      bind = true,
      doc_lines = 0,
      transparency = 1,
      handler_opts = {
        border = "single",
      },
      hint_enable = false,
      hint_prefix = {
        above = "↙ ", -- when the hint is on the line above the current line
        current = "← ", -- when the hint is on the same line
        below = "↖ ", -- when the hint is on the line below the current line
      },
      hi_parameter = "MatchParen",
    },
    keys = {
      {
        "<C-g>",
        function()
          require("lsp_signature").toggle_float_win()
        end,
        mode = "i",
        desc = "Toggle lsp signature",
      },
    },
    config = function(_, opts)
      require("lsp_signature").setup(opts)
      LazyVim.lsp.on_attach(function(client, buffer)
        require("lsp_signature").on_attach({}, buffer)
      end)
    end,
  },
}
