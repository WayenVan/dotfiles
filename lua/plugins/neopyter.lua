return {

  {
    "SUSTech-data/neopyter",
    ft = "python",
    dependencies = {
      {
        "AbaoFromCUG/websocket.nvim",
      },
    },
    ---@type neopyter.Option
    opts = {
      mode = "proxy",
      auto_connect = false,
      remote_address = "127.0.0.1:9001",
      file_pattern = { "*.ju.*" },
      on_attach = function(buf)
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { desc = desc, buffer = buf })
        end
        map("n", "<laeder>j", "", "Jupyter")
        -- same, recommend the former
        map("n", "<C-Enter>", "<cmd>Neopyter execute notebook:run-cell<cr>", "run selected")
        -- map("n", "<C-Enter>", "<cmd>Neopyter run current<cr>", "run selected")

        -- same, recommend the former
        map("n", "<leader>jx", "<cmd>Neopyter execute notebook:run-all-above<cr>", "run all above cell")
        -- map("n", "<space>X", "<cmd>Neopyter run allAbove<cr>", "run all above cell")
        map("n", "<leader>jX", "<cmd>Neopyter run allBelow<cr>", "run all above cell")

        -- same, recommend the former, but the latter is silent
        map("n", "<leader>jr", "<cmd>Neopyter execute kernelmenu:restart<cr>", "restart kernel")

        -- map("n", "<S-Enter>", "<cmd>Neopyter execute runmenu:run<cr>", "run selected and select next")
        -- map("n", "<M-Enter>", "<cmd>Neopyter execute run-cell-and-insert-below<cr>", "run selected and insert below")

        map("n", "<leader>jR", "<cmd>Neopyter execute notebook:restart-run-all<cr>", "restart kernel and run all")

        map("n", "<leader>jd", "<cmd>Neopyter disconnect<cr>", "disconnect")
        map("n", "<leader>jj", "<cmd>Neopyter connect<cr>", "connect to kernel")
      end,
      highlight = {
        enable = true,
        shortsighted = false,
      },
      parser = {
        -- trim leading/tailing whitespace of cell
        trim_whitespace = false,
      },
    },
  },
}
