return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- enabled = false,
    opts = {
      -- rainbow = {
      --   enable = true,
      --   extended_mode = false,
      --   max_file_lines = nil,
      -- },
      -- diable large file
      disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },
  },
}
