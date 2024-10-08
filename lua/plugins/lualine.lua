return {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        require("lualine").setup({
          options = {
            icons_enabled = true,
            theme = "auto",
            component_separators = { left = "|", right = "|" },
            section_separators = { left = "|", right = "|" },
          },
          sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch" },
            lualine_c = {
              "filename",
              {
                function()
                  return vim.fn.wordcount().words .. " words"
                end,
              },
            },
            lualine_x = { 
              "filetype",
              {
              "fileformat",
              symbols = {
                unix = '', -- e712
                dos = '',  -- e70f
                mac = '',  -- e711
              }
             }
            },
            lualine_y = { "progress" },
            lualine_z = { "location" },
          },
          tabline = {
            lualine_a = {'buffers'},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {'tabs'}
          },
          extensions = { "lazy", "fugitive" },
          winbar = {
            lualine_a = {
              {
                "filename",
                path = 2
              }
            },
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {}
          }
        })
      end,
}
