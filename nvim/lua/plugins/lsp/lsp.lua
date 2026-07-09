-- NOTE: hack function for lspeek.nvim
local function open_preview(location)
  local util = require("lspeek.util")
  local window = require("lspeek.window")
  local uri = util.normalize_uri(location.uri or location.targetUri)
  local bufnr = util.ensure_loaded_buf(uri)
  local fname = vim.uri_to_fname(uri)

  local source = window.get_source()
  local target = window.build_target_from_location(location, bufnr, fname)

  local preview = window.create_preview_floating_window(source, target)

  -- add customized keymap to close the preview window and jump to the target window
  vim.keymap.set("n", "<S-enter>", function()
    local pos = vim.api.nvim_win_get_cursor(preview.win)
    -- close all preview windows
    window.close_all_previews()

    -- pickup window
    require("snacks")
    local win_id = Snacks.picker.util.pick_win({ main = vim.api.nvim_get_current_win() })
    -- vim.api.nvim_win_set_buf(win_id, target.buf)
    vim.fn.win_execute(win_id, "edit " .. vim.fn.fnameescape(vim.api.nvim_buf_get_name(target.buf)))

    pcall(vim.api.nvim_win_set_cursor, win_id, pos)
    pcall(vim.api.nvim_set_current_win, win_id)
    vim.keymap.del("n", "<S-enter>", { buffer = target.buf })
  end, { buffer = target.buf, desc = "Close lspeek preview" })

  if preview and vim.api.nvim_win_is_valid(preview.win) then
    pcall(vim.api.nvim_win_set_cursor, preview.win, util.lsp_pos_to_vim_cursor(target.pos))
  end
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
        opts = {
          lsp = { auto_attach = true },
          source_buffer = {
            reorient = "none", -- "smart" | "none"
          },
        },
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
            require("snacks")
            Snacks.picker.pick({
              finder = "lsp_definitions",
              format = "file",
              include_current = false,
              auto_confirm = true,
              confirm = function(picker, item)
                picker:close()
                local lsp_item = require("utils.lsp_picker_converter").PickerToLsp(item)

                open_preview(lsp_item)
              end,
              jump = { tagstack = true, reuse_win = true },
            })
          end,
          desc = "Peek Definition (lspeek) with Snacks picker",
        },
        {
          "gT",
          function()
            require("snacks")
            Snacks.picker.pick({
              finder = "lsp_type_definitions",
              format = "file",
              include_current = false,
              auto_confirm = true,
              confirm = function(picker, item)
                picker:close()
                local lsp_item = require("utils.lsp_picker_converter").PickerToLsp(item)

                open_preview(lsp_item)
              end,
              jump = { tagstack = true, reuse_win = true },
            })
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
    end,
  },
}
