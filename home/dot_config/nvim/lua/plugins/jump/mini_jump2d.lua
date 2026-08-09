return {
  {
    "nvim-mini/mini.jump2d",
    version = false,
    enabled = false,
    config = function()
      require("mini.jump2d").setup({
        -- Module mappings. Use `''` (empty string) to disable one.
        mappings = {
          start_jumping = "<leader>j",
        },
      })
    end,
  },
}
