return {
  {
    "debugloop/layers.nvim",
    lazy = false,
    init = function()
      _G.LayersManager = {
        layers = {},
        activated_layers = {}, -- Consider using a Set-like table instead
        activate = function(self, name)
          if not self.layers[name] then
            error("Layer " .. name .. " not found")
          end
          if self.layers[name]:active() then
            vim.notify("Layer " .. name .. " is already active", vim.log.levels.WARN)
            return
          end
          self.layers[name]:activate()
          -- Prevent duplicates
          if not vim.tbl_contains(self.activated_layers, name) then
            table.insert(self.activated_layers, name)
          end
        end,
        deactivate = function(self, name)
          if not self.layers[name] then
            error("Layer " .. name .. " not found")
          end
          if not self.layers[name]:active() then
            vim.notify("Layer " .. name .. " is not active", vim.log.levels.WARN)
            return
          end
          self.layers[name]:deactivate()
          -- Safer removal using table filter
          self.activated_layers = vim.tbl_filter(function(layer)
            return layer ~= name
          end, self.activated_layers)
        end,
      }
    end,
    keys = {
      {
        "<leader>D",
        function()
          LayersManager:activate("DRAW")
        end,
        { desc = "Activate Draw Layer" },
      },
      {
        "<leader>$",
        function()
          LayersManager:activate("REPL")
        end,
        { desc = "Activate REPL layer" },
      },
      {
        "<leader>W",
        function()
          LayersManager:activate("WINDOW")
        end,
        { desc = "Activate REPL layer" },
      },
      {
        "<leader>%",
        function()
          LayersManager:activate("VIMTEX")
        end,
        { desc = "Activate VIMTEX layer" },
      },
    },
    config = function()
      require("layers").setup({})
      require("plugins.layers.sublayers.draw")
      require("plugins.layers.sublayers.repl")
      require("plugins.layers.sublayers.window")
      require("plugins.layers.sublayers.vimtex")
    end,
  },
}
