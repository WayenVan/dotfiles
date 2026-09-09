local function peek_with_snacks(finder)
  require("snacks").picker.pick({
    finder = finder,
    format = "file",
    include_current = false,
    auto_confirm = true,
    layout = { preset = "vertical" },
    jump = { tagstack = true, reuse_win = true },
    confirm = function(picker, item)
      local source_win = picker.main
      picker:close()

      if source_win and vim.api.nvim_win_is_valid(source_win) then
        vim.api.nvim_set_current_win(source_win)
      end

      local location = require("utils.lsp_picker_converter").PickerToLsp(item)
      require("utils.lspeek").open_preview(location)
    end,
  })
end
return {
  -- change lsp keymaps
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        config = function()
          local actions = require("nvim-navbuddy.actions")
          require("nvim-navbuddy").setup({
            lsp = { auto_attach = true },
            source_buffer = {
              reorient = "none", -- "smart" | "none"
            },
            use_default_mappings = false,
            mappings = {
              ["q"] = actions.close(),
              ["<enter>"] = actions.select(), -- Goto selected symbol
              ["<localleader>v"] = actions.vsplit(), -- Open selected node in a vertical split
              ["<localleader>s"] = actions.hsplit(), -- Open selected node in a horizontal split
              ["j"] = actions.next_sibling(), -- down
              ["k"] = actions.previous_sibling(), -- up

              ["h"] = actions.parent(), -- Move to left panel
              ["l"] = actions.children(), -- Move to right panel
              ["r"] = actions.rename(), -- Rename currently focused symbol

              ["d"] = actions.delete(), -- Delete scope
              ["J"] = actions.move_down(), -- Move focused node down
              ["K"] = actions.move_up(), -- Move focused node up

              ["y"] = actions.yank_name(), -- Yank the name to system clipboard "+
              ["Y"] = actions.yank_scope(), -- Yank the scope to system clipboard "+

              ["i"] = actions.insert_name(), -- Insert at start of name
              ["I"] = actions.insert_scope(), -- Insert at start of scope
              -- ["s"] = {
              --   callback = function()
              --     require("flash").jump({
              --       multi_window = false,
              --       highlight = { backdrop = true },
              --       label = {
              --         rainbow = { enabled = true },
              --       },
              --     })
              --   end,
              --   desc = "Flash",
              -- },
            },
          })
        end,
      },
      "r4ppz/lspeek.nvim",
    },
    opts = function(_, opts)
      opts.servers["*"].keys = vim.list_extend(opts.servers["*"].keys, {
        {
          "<leader>ca",
          function()
            require("actions-preview").code_actions()
          end,
          desc = "Code action preview",
        },
        {
          "gd",
          function()
            peek_with_snacks("lsp_definitions")
          end,
          desc = "Peek Definition (lspeek) with Snacks picker",
        },
        {
          "gT",
          function()
            peek_with_snacks("lsp_type_definitions")
          end,
          desc = "Peek Type Definition (lspeek) with Snacks picker",
        },
        {
          "<C-k>",
          "<cmd>lua vim.lsp.buf.signature_help()<cr>",
          desc = "open lsp signature help",
          mode = "i",
        },
        {
          "<M-i>",
          function()
            local bufnr = vim.api.nvim_get_current_buf()
            local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr })
            if not enabled then
              vim.lsp.inlay_hint.enable(true, {
                bufnr = bufnr,
              })
            else
              vim.lsp.inlay_hint.enable(false, {
                bufnr = bufnr,
              })
            end
          end,
          desc = "Momentarily show inlay hints via Alt‑h",
          mode = "n",
        },

        { "<leader>cn", "<cmd>Navbuddy<cr>", desc = "NavBuddy" },
        -- {
        --   "<leader>ss",
        --   function()
        --     Snacks.picker.lsp_symbols({
        --       filter = LazyVim.config.kind_filter,
        --     })
        --   end,
        --   desc = "LSP Symbols",
        --   has = "documentSymbol",
        -- },
      })

      -- disable diagnostic virtual text configured by lspconfig, using the tiny one
      opts.diagnostics.virtual_text = false
      opts.inlay_hints = {
        enabled = false,
      }

      -- vim.diagnostic.config({ virtual_lines = true })
      -- disalbe vim log
      -- vim.lsp.set_log_level("off")

      -- toggle diagnostic virtual text
      -- vim.keymap.set("", "<leader>k", function()
      --   vim.diagnostic.config({
      --     virtual_lines = not vim.diagnostic.config().virtual_lines,
      --     virtual_text = not vim.diagnostic.config().virtual_text,
      --   })
      -- end, { desc = "Toggle diagnostic [l]ines" })
      vim.diagnostic.config({ float = { source = true } })
      -- opts.servers["marksman"] = {
      --   enabled = false,
      -- }
      opts.servers["markdownlint"] = {
        enabled = false,
      }
    end,
  },
}
