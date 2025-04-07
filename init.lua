local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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

require("vim-options")
require("lazy").setup("plugins")
require("keymaps")
require("vimstar-user")

vim.g.transparency = 0.8

if vim.g.neovide then 
 -- vim.g.neovide_opacity = 0.0
  vim.g.neovide_normal_opacity = 0.8
  vim.g.neovide_window_blurred = true
end
