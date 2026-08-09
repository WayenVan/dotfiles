return {
  {
    "nvchad/volt",
    config = function()
      vim.api.nvim_create_augroup("_volt", { clear = true })
      local reset_hl = function()
        -- reset the
        local module_name = "volt.highlights" -- replace with your module name
        package.loaded[module_name] = nil
        require(module_name)
      end
      vim.api.nvim_create_autocmd("OptionSet", {
        group = "_volt",
        pattern = "background",
        callback = reset_hl,
      })
      vim.api.nvim_create_autocmd("ColorScheme", {
        group = "_volt",
        callback = reset_hl,
      })
    end,
    lazy = true,
  },
}
