return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        diagnostics = false,
        indicator = {
          -- style = "underline",
        },
        separator_style = "thin",
        groups = {
          items = {
            require("bufferline.groups").builtin.pinned:with({ icon = "📌" }), -- Group for pinned buffers
            {
              name = "Tests",
              matcher = function(buf)
                return buf.name:match("%_test") or buf.name:match("%_spec")
              end,
            },
            {
              name = "Docs",
              matcher = function(buf)
                return buf.name:match("%.md") or buf.name:match("%.txt")
              end,
            },
          },
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },
}
