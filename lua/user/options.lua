-- Core options: raw markdown, Ember light, Goyo by default.

local opt = vim.opt

-- files
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.hidden = true

-- editing
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.autoindent = true
opt.smartindent = true
opt.virtualedit = "block"

-- search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = false

-- ui: light default, system dark detection happens in plugins.lua
opt.termguicolors = true
opt.background = "light"
opt.number = false
opt.relativenumber = false
opt.signcolumn = "no"
opt.cursorline = false
opt.showmode = false
opt.laststatus = 0
opt.cmdheight = 1
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.splitbelow = true
opt.splitright = true
opt.fillchars = { eob = " ", fold = " ", foldopen = "▾", foldclose = "▸" }
opt.list = false
opt.listchars = { tab = "  ", trail = "·", eol = nil }
opt.pumheight = 10
opt.timeoutlen = 400
opt.updatetime = 250
opt.clipboard = "unnamedplus"
opt.mouse = "a"

-- writing: raw markdown, no conceals, no visible newline markers
opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.showbreak = "" -- don't render wrapped lines with ↳
opt.textwidth = 0
opt.conceallevel = 0
opt.concealcursor = ""
opt.formatoptions = "jcroql"
opt.spell = false
opt.spelllang = { "en_us" }

-- folds off
opt.foldenable = false
opt.foldmethod = "manual"
opt.foldlevelstart = 99

opt.statusline = " %f %m  %=%{wordcount().words}w  %l:%c "

-- disable netrw (oil)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
