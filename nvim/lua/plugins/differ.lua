return {
  {
    "undont/differ.nvim",
    build = "make go-build",

    cmd = { "Differ", "D" }, -- "D" matches command_alias below; see note above
    keys = {
      -- local diff / history
      { "<leader>gd", "", desc = "+Differ" },
      { "<leader>gdo", "<cmd>Differ<CR>", desc = "Diff: open (vs index)" },
      -- { "<leader>gdc", "<cmd>Differ close<CR>", desc = "Diff: close" },
      { "<leader>gdt", "<cmd>Differ base<CR>", desc = "Diff: branch total (vs base)" },
      { "<leader>gde", "<cmd>Differ gofile<CR>", desc = "Diff: open the real file" },
      { "<leader>gdd", "<cmd>Differ panel<CR>", desc = "Diff: panel toggle" },
      { "<leader>gdh", "<cmd>Differ log<CR>", desc = "Diff: file history" },
      { "<leader>gdp", "<cmd>Differ log origin/HEAD...HEAD<CR>", desc = "Diff: PR range (local, no API)" },
      { "<leader>gdl", "<cmd>Differ layout<CR>", desc = "Diff: toggle layout" },
      -- pr review (sidecar + github)
      -- { "<leader>pl", "<cmd>Differ pr list<CR>", desc = "PR: list" },
      -- {
      --   "<leader>po",
      --   function()
      --     vim.ui.input({ prompt = "PR number: " }, function(input)
      --       if input and input ~= "" then
      --         vim.cmd("Differ pr " .. input)
      --       end
      --     end)
      --   end,
      --   desc = "PR: open by number",
      -- },
      -- { "<leader>pr", "<cmd>Differ pr review<CR>", desc = "PR: review start" },
      -- { "<leader>pe", "<cmd>Differ pr review resume<CR>", desc = "PR: review resume" },
      -- { "<leader>pm", "<cmd>Differ pr review submit<CR>", desc = "PR: review submit" },
      -- { "<leader>pd", "<cmd>Differ pr review discard<CR>", desc = "PR: review discard" },
      -- { "<leader>psm", "<cmd>Differ pr merge squash<CR>", desc = "PR: squash merge" },
      -- { "<leader>pk", "<cmd>Differ pr checks<CR>", desc = "PR: checks" },
      -- { "<leader>pO", "<cmd>Differ pr checkout<CR>", desc = "PR: checkout" },
      -- { "<leader>pR", "<cmd>Differ pr ready<CR>", desc = "PR: mark ready" },
      -- { "<leader>pD", "<cmd>Differ pr draft<CR>", desc = "PR: mark draft" },
      -- { "<leader>pX", "<cmd>Differ pr close<CR>", desc = "PR: close" },
      -- { "<leader>pb", "<cmd>Differ pr browser<CR>", desc = "PR: open in browser" },
      -- { "<leader>py", "<cmd>Differ pr url<CR>", desc = "PR: yank URL" },
      -- { "<leader>pq", "<cmd>Differ close<CR>", desc = "PR: quit" },
    },
    config = function()
      require("differ").setup()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "differdiff", "differhistory", "differpanel" },
        group = vim.api.nvim_create_augroup("_differ", { clear = true }),
        callback = function(env)
          vim.keymap.set("n", "q", "<cmd>Differ close<CR>", { buffer = env.buf, desc = "Close differ" })
        end,
      })
    end,
  },
}
