return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    -- the config of this plugin does not merging, wweird??
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      render_modes = { "n", "c", "t" },
      file_types = { "codecompanion", "Avante", "markdown" },
    },
  },
}
