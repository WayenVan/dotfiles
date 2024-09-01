return {
  {
    "milanglacier/yarepl.nvim",
    event = "VeryLazy",
    config = function(_, opts)
      local bufmap = vim.api.nvim_buf_set_keymap
      local auto_cmd = vim.api.nvim_create_autocmd
      vim.api.nvim_create_augroup("REPL", { clear = true })
      auto_cmd("FileType", {
        pattern = { "quarto", "markdown", "markdown.pandoc", "rmd", "python", "sh", "REPL", "r" },
        group = "REPL",
        desc = "set up REPL keymap",
        callback = function()
          bufmap(0, "n", "<leader>rf", "<CMD>REPLFocus<CR>", {
            desc = "Focus on REPL",
          })
          bufmap(0, "n", "<leader>rs", "<CMD>Telescope REPLShow<CR>", {
            desc = "View REPLs in telescope",
          })
          bufmap(0, "n", "<leader>rh", "<CMD>REPLHide<CR>", {
            desc = "Hide REPL",
          })
          bufmap(0, "v", "<leader>rr", "<CMD>REPLSendVisual<CR>", {
            desc = "Send visual region to REPL",
          })
          bufmap(0, "n", "<leader>rr", "<CMD>REPLSendLine<CR>", {
            desc = "Send line to REPL",
          })
          bufmap(0, "n", "<leader>ro", "<CMD>REPLSendOperator<CR>", {
            desc = "Send current line to REPL",
          })
          bufmap(0, "n", "<leader>rq", "<CMD>REPLClose<CR>", {
            desc = "Quit REPL",
          })
          bufmap(0, "n", "<leader>rD", "<CMD>REPLCleanup<CR>", {
            desc = "Clear REPLs.",
          })
          bufmap(0, "n", "<leader>rS", "<CMD>REPLSwap<CR>", {
            desc = "Swap REPLs.",
          })
          bufmap(0, "n", "<leader>rc", "<CMD>REPLStart<CR>", {
            desc = "Start an REPL from available REPL metas",
          })
          bufmap(0, "n", "<leader>ra", "<CMD>REPLAttachBufferToREPL<CR>", {
            desc = "Attach current buffer to a REPL",
          })
          bufmap(0, "n", "<leader>rd", "<CMD>REPLDetachBufferToREPL<CR>", {
            desc = "Detach current buffer to any REPL",
          })
        end,
      })
      require("yarepl").setup(opts)
    end,
  },
}
