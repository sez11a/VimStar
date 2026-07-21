local depcheck = require("vimstar.depcheck")

return {
  {
    "monkoose/neocodeium",
    cond = function() return depcheck.has_ollama() end,
    event = "InsertEnter",
    config = function()
      require("neocodeium").setup({
        enabled = false,
      })
      vim.keymap.set("i", "<C-y>", function() require("neocodeium").accept() end, { desc = "Accept AI suggestion" })
      vim.keymap.set("i", "<A-e>", function() require("neocodeium").cycle_or_complete() end,
        { desc = "Trigger/Cycle NeoCodeium" })
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    cond = function() return depcheck.has_ollama() end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("codecompanion").setup({
        opts = {
          show_reasoning = false,
        },
        adapters = {
          ollama = {
            schema = { model = vim.g.ollama_model or "gemma4-31b-256k" },
          },
        },
        strategies = {
          chat = { adapter = "ollama", model = vim.g.ollama_model or "gemma4-31b-256k" },
          inline = { adapter = "ollama", model = vim.g.ollama_model or "gemma4-31b-256k" },
        },
      })
    end,
  },
}