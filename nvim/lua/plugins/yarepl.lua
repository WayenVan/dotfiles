return {
  {
    "milanglacier/yarepl.nvim",
    ft = { "quarto", "markdown", "markdown.pandoc", "rmd", "python", "sh", "REPL", "r" },
    config = function(_, opts)
      local bufmap = vim.api.nvim_buf_set_keymap
      local auto_cmd = vim.api.nvim_create_autocmd

      -- Function to delete buffers with a specific filetype and close the windows showing those buffers
      local function delete_buffers_by_filetype(filetype)
        -- Iterate over all buffers
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          -- Check if the buffer is loaded and its filetype matches the target
          if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype == filetype then
            -- Close all windows displaying this buffer
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              if vim.api.nvim_win_get_buf(win) == buf then
                vim.api.nvim_win_close(win, true)
              end
            end
            -- Delete the buffer
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end
      end
      vim.api.nvim_create_user_command("REPLDeleteALL", function()
        delete_buffers_by_filetype("REPL")
      end, {})

      -- Example usage: Delete all buffers with filetype 'REPL'
      -- delete_buffers_by_filetype("REPL")
      -- vim.api.nvim_create_augroup("REPL", { clear = true })
      -- auto_cmd("FileType", {
      --   pattern = { "quarto", "markdown", "markdown.pandoc", "rmd", "python", "sh", "REPL", "r" },
      --   group = "REPL",
      --   desc = "set up REPL keymap",
      --   callback = function()
      --     bufmap(0, "n", "<localleader>r", "", {
      --       desc = "+ REPL",
      --     })
      --     bufmap(0, "n", "<localleader>rf", "<CMD>REPLFocus<CR>", {
      --       desc = "Focus on REPL",
      --     })
      --     bufmap(0, "n", "<localleader>rs", "<CMD>Telescope REPLShow<CR>", {
      --       desc = "View REPLs in telescope",
      --     })
      --     bufmap(0, "n", "<localleader>rh", "<CMD>REPLHide<CR>", {
      --       desc = "Hide REPL",
      --     })
      --     bufmap(0, "v", "<localleader>rr", "<CMD>REPLSendVisual<CR>", {
      --       desc = "Send visual region to REPL",
      --     })
      --     bufmap(0, "n", "<localleader>rr", "<CMD>REPLSendLine<CR>", {
      --       desc = "Send line to REPL",
      --     })
      --     bufmap(0, "n", "<localleader>ro", "<CMD>REPLSendOperator<CR>", {
      --       desc = "Send current line to REPL",
      --     })
      --     bufmap(0, "n", "<localleader>rq", "<CMD>REPLClose<CR>", {
      --       desc = "Quit REPL",
      --     })
      --     bufmap(0, "n", "<localleader>rQ", "<CMD>REPLDeleteALL<CR>", {
      --       desc = "Forcequit all REPLs",
      --     })
      --     bufmap(0, "n", "<localleader>rc", "<CMD>REPLCleanup<CR>", {
      --       desc = "Clear REPLs.",
      --     })
      --     bufmap(0, "n", "<localleader>rS", "<CMD>REPLSwap<CR>", {
      --       desc = "Swap REPLs.",
      --     })
      --     bufmap(0, "n", "<localleader>ra", "<CMD>REPLStart<CR>", {
      --       desc = "Start an REPL from available REPL metas",
      --     })
      --     bufmap(0, "n", "<localleader>rA", "<CMD>REPLAttachBufferToREPL<CR>", {
      --       desc = "Attach current buffer to a REPL",
      --     })
      --     bufmap(0, "n", "<localleader>rd", "<CMD>REPLDetachBufferToREPL<CR>", {
      --       desc = "Detach current buffer to any REPL",
      --     })
      --   end,
      -- })
      require("yarepl").setup(opts)
    end,
  },
}
