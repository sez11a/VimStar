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

if vim.g.neovide then 
  vim.g.neovide_transparency = 0.4
  vim.g.neovide_window_blurred = true
end
