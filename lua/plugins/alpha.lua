return {
  "goolord/alpha-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.startify")

    dashboard.section.header.val = {
      [[                                                               ]],
      [[                                                               ]],
      [[▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄]],
      [[                                         ]],
      [[                    ▌ ▌▗     ▞▀▖▐        ]],
      [[                    ▚▗▘▄ ▛▚▀▖▚▄ ▜▀ ▝▀▖▙▀▖]],
      [[                    ▝▞ ▐ ▌▐ ▌▖ ▌▐ ▖▞▀▌▌  ]],
      [[                     ▘ ▀▘▘▝ ▘▝▀  ▀ ▝▀▘▘  ]],
      [[                                         ]],
      [[▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄]],
    }

    local function wordstar_netrw()
      -- Leave the greeter so splits behave normally.
      vim.cmd("enew")

      -- Empty buffer on top, Netrw below (~40% of the screen).
      vim.cmd("botright split")
      vim.cmd("resize " .. math.floor(vim.o.lines * 0.4))
      vim.cmd("Explore")

      local netrw_win = vim.api.nvim_get_current_win()
      local netrw_buf = vim.api.nvim_get_current_buf()
      vim.b[netrw_buf].vimstar_file_picker = true

      -- When a real file lands in a window, collapse to one window.
      local aug = vim.api.nvim_create_augroup("VimStarNetrwPicker", { clear = true })
      vim.api.nvim_create_autocmd("BufWinEnter", {
        group = aug,
        callback = function(ev)
          local ft = vim.bo[ev.buf].filetype
          local name = vim.api.nvim_buf_get_name(ev.buf)
          if ft == "netrw" or ft == "alpha" or name == "" then
            return
          end
          -- Only fire if this picker session is still around.
          if not vim.api.nvim_win_is_valid(netrw_win) then
            return
          end
          vim.schedule(function()
            if vim.api.nvim_buf_is_valid(ev.buf) then
              vim.api.nvim_set_current_buf(ev.buf)
              vim.cmd("only")
            end
            pcall(vim.api.nvim_del_augroup_by_id, aug)
          end)
        end,
      })
    end

    dashboard.section.top_buttons.val = {
      dashboard.button("e", "New file", "<cmd>ene <CR>"),
      dashboard.button("f", "Open file", function()
        wordstar_netrw()
      end),
    }

    alpha.setup(dashboard.opts)
  end,
}
