return {
  {
    "lervag/vimtex",
    lazy = false, -- lazy-loading will disable inverse search
    config = function()
      vim.g.vimtex_mappings_disable = { ["n"] = { "K" } } -- disable `K` as it conflicts with LSP hover
      vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
      -- vim.api.nvim_create_augroup("_vimtex", { clear = true })
      -- -- Create an autocommand to run when entering a directory
      -- vim.api.nvim_create_autocmd({ "BufRead" }, {
      --   group = "_vimtex",
      --   callback = function()
      --     if not (vim.bo.filetype == "tex" or vim.bo.filetype == "bib") then
      --       vim.api.nvim_buf_del_keymap("")
      --     end
      --   end,
      -- })
    end,
    keys = {
      { "<localLeader>l", "", desc = "+vimtext" },
    },
  },
}
