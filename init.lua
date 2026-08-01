-- Markdown-first Neovim: fast, clean, gorgeous.
vim.loader.enable()

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("user.options")
require("user.keymaps")
require("user.plugins")
