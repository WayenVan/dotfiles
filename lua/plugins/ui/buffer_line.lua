return {
  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        indicator = {
          style = "underline",
        },
        separator_style = "slope",
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
  },
}
