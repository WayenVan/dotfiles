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
      require("ufo").setup({
        provider_selector = function(bufnr, filetype, buftype)
          -- 仅对普通文件启用
          if buftype ~= "" then
            return ""
          end

          -- 排除部分特殊 filetype
          local excluded_filetypes = {
            dashboard = true,
            snacks_dashboard = true,
            snacks_picker_list = true,
            neo_tree = true,
            NvimTree = true,
            oil = true,
            trouble = true,
            lazy = true,
            mason = true,
            notify = true,
            qf = true,
            help = true,
            man = true,
            gitcommit = true,
            toggleterm = true,
            fish = true,
            tmux = true,
            ["dap-view"] = true,
            ["dap-view-term"] = true,
          }

          if excluded_filetypes[filetype] then
            return ""
          end

          return { "lsp", "treesitter" }
        end,
      })
    end,
  },
}
