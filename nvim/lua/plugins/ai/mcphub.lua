return {
  {
    "ravitemer/mcphub.nvim",
    event = "VeryLazy",
    enabled = false, -- Disable the plugin by default
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest", -- Installs `mcp-hub` node binary globally
    config = function()
      require("mcphub").setup()
    end,
  },
}
