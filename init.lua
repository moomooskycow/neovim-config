-- Markdown-first Neovim: fast, clean, gorgeous.
vim.loader.enable()

-- Ensure config root is on runtimepath for standalone or symlinked runs
local config_dir = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p:h")
if not vim.tbl_contains(vim.opt.rtp:get(), config_dir) then
	vim.opt.rtp:prepend(config_dir)
end

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("user.options")
require("user.keymaps")
require("user.plugins")
