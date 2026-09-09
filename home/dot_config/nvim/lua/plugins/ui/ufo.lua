return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    init = function()
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
    end,
    keys = {
      {
        "zR",
        function()
          require("ufo").openAllFolds()
        end,
        desc = "Open all folds",
      },
      {
        "zM",
        function()
          require("ufo").closeAllFolds()
        end,
        desc = "Close all folds",
      },
      {
        "zp",
        function()
          require("ufo").peekFoldedLinesUnderCursor()
        end,
        desc = "Preview fold",
      },
    },
    event = "BufReadPost",
    config = function()
      -- Keep this table small and only add filetypes with a confirmed provider bug.
      -- Most unsupported filetypes automatically fall back from treesitter to indent.
      local provider_overrides = {
        -- Example: problematic_filetype = "indent",
        -- Example: incompatible_filetype = "",
      }

      require("ufo").setup({
        provider_selector = function(_, filetype, buftype)
          -- Special/plugin buffers own their folding behavior.
          if buftype ~= "" or filetype == "" or filetype == "bigfile" then
            return ""
          end

          -- LSP folding errors do not always trigger ufo's fallback. Tree-sitter
          -- reliably falls back to indent when no parser/folds query is available.
          return provider_overrides[filetype] or { "treesitter", "indent" }
        end,
      })
    end,
  },
}
