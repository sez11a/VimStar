vim.g.mapleader = " "
vim.g.maplocalleader = " "
local ts_path = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter"
vim.opt.runtimepath:prepend(ts_path)
local parser_path = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/parser"
vim.opt.runtimepath:prepend(parser_path)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

function getWords()
  return tostring(vim.fn.wordcount().words)
end

-- require("lazy").setup("plugins")
require("lazy").setup({
    { import = "plugins" },
    { import = "user.plugins" },
})
require("vim-options")
require("vimstar.functions")
require("vimstar.blocks")
require("keymaps")
require("vimstar-user")

