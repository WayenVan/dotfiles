return {
  {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
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
          hint_prefix = " ",
        }, buffer)
      end)
    end,
  },
}
