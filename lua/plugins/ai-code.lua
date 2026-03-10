return {
  {
    "monkoose/neocodeium",
    event = "InsertEnter",  -- lazy-load on insert
    config = function()
      require("neocodeium").setup({
        -- optional: enable/disable filetypes, etc.
        enabled = false,
      })
      -- Map accept (default Tab might conflict; adjust to your prefs)
      vim.keymap.set("i", "<C-y>", function() require("neocodeium").accept() end, { desc = "Accept AI suggestion" })
      vim.keymap.set("i", "<A-e>", function() require("neocodeium").cycle_or_complete() end,
        { desc = "Trigger/Cycle NeoCodeium" })
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      { "MeanderingProgrammer/render-markdown.nvim", opts = {} }, -- nice for chat rendering
    },
    config = function()
      require("codecompanion").setup({
        opts = {
          show_reasoning = false,
          -- show_settings = false,
        },
        adapters = {
          -- Pick one or more; example with Ollama (local/free) or Anthropic
          ollama = {
            -- schema = { model = "codellama" },
            schema = { model = "qwen3-coder-next" },
          },
          -- anthropic = { env = { api_key = "your-claude-key" } },
        },
        strategies = {
          -- chat = { adapter = "ollama" }, -- or "anthropic"
          chat = { adapter = "ollama", model = "qwen3-coder-next" }, -- or "anthropic"
          inline = { adapter = "ollama", model = "qwen3-coder-next" },
        },
        vim.keymap.set("i", "C-l", "<cmd>CodeCompanionInline<cr>", { desc = "Ollama Inline Suggestion" })
      })
    end,
  },
}
