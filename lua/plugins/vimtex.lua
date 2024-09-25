return {
  "lervag/vimtex",
  lazy = false,     -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    --vim.g.vimtex_view_method = "zathura"
    vim.g.vimtex_view_general_viewer = "okular"
    vim.cmd("let g:vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'")
  end
}
