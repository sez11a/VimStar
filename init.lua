vim.g.mapleader = " "
vim.g.maplocalleader = " "
local _v = vim.version()
local _is_modern = (_v.major == 0 and _v.minor >= 12) or _v.major > 0
vim.g.tree_sitter_branch = _is_modern and "main" or "master"
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

