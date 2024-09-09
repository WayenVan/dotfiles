return {
  {
    "SUSTech-data/neopyter",
    lazy = true,
    enabled = false,
    cmd = {
      "Neopyter",
    },
    init = function()
      -- create auto command that when python file is loaded, applying keymap <leader>cj for it
      vim.api.nvim_create_augroup("Neopyter", { clear = true })
      vim.api.nvim_create_autocmd({ "FileType" }, {
        group = "Neopyter",
        pattern = "python",
        callback = function()
          vim.api.nvim_buf_set_keymap(0, "n", "<leader>j", "", { noremap = true, silent = true, desc = "+Neopyter" })
          vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "<leader>jc",
            "<CMD>Neopyter connect 127.0.0.1:9001<CR>",
            { noremap = true, silent = true, desc = "connect to a server" }
          )
          vim.api.nvim_buf_set_keymap(
            0,
            "n",
            "<leader>jd",
            "<CMD>Neopyter disconnect<CR>",
            { noremap = true, silent = true, desc = "Disconnect" }
          )
        end,
      })
    end,
    ---@type neopyter.Option
    opts = {
      mode = "proxy",
      remote_address = "127.0.0.1:9001",
      file_pattern = { "*.ju.*" },
      on_attach = function(buf)
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { desc = desc, buffer = buf })
        end
        -- same, recommend the former
        map("n", "<C-Enter>", "<cmd>Neopyter execute notebook:run-cell<cr>", "run selected")
        -- map("n", "<C-Enter>", "<cmd>Neopyter run current<cr>", "run selected")

        -- same, recommend the former
        map("n", "<localleader>X", "<cmd>Neopyter execute notebook:run-all-above<cr>", "run all above cell")
        -- map("n", "<space>X", "<cmd>Neopyter run allAbove<cr>", "run all above cell")

        -- same, recommend the former, but the latter is silent
        map("n", "<localleader>R", "<cmd>Neopyter execute kernelmenu:restart<cr>", "restart kernel")
        -- map("n", "<space>nt", "<cmd>Neopyter kernel restart<cr>", "restart kernel")
        --

        -- map("n", "<S-Enter>", "<cmd>Neopyter execute runmenu:run<cr>", "run selected and select next")
        -- map("n", "<M-Enter>", "<cmd>Neopyter execute run-cell-and-insert-below<cr>", "run selected and insert below")
        --
        -- map("n", "<F5>", "<cmd>Neopyter execute notebook:restart-run-all<cr>", "restart kernel and run all")
      end,
      highlight = {
        enable = false,
        shortsighted = false,
      },
      parser = {
        -- trim leading/tailing whitespace of cell
        trim_whitespace = false,
      },
    },
  },
}
