return {
  {
    "tpope/vim-fugitive"
  },

  {
        "idanarye/vim-merginal"
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end
  },
  {
    "airblade/vim-rooter",
  },
}
