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
      local ollama_model = vim.g.ollama_model or "llama3.1-8b"
      require("codecompanion").setup({
        interactions = {
            chat = {
                sessions = {
                    enabled = true,
                    autosave = true,
                    continuous_save = true,
                    save_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "codecompanion", "sessions"),
                },
            },
        },
        opts = {
          show_reasoning = false,
        },
        adapters = {
          ollama = {
            schema = { model = ollama_model },
          },
        },
        strategies = {
          chat = { adapter = "ollama", model = ollama_model },
          inline = { adapter = "ollama", model = ollama_model },
        },
      })
    end,
  },
}