-- Markdown buffer: raw, gorgeous, Goyo-ready.

local opt = vim.opt_local

opt.spell = false
opt.wrap = true
opt.linebreak = true
opt.breakindent = true
opt.showbreak = "" -- no ↳
opt.list = false
opt.number = false
opt.relativenumber = false
opt.signcolumn = "no"
opt.cursorline = false
opt.conceallevel = 0
opt.concealcursor = ""
opt.textwidth = 0
opt.colorcolumn = ""
opt.foldenable = false
opt.formatoptions:remove({ "t", "c" })
opt.statusline = " %f %m  %=%{wordcount().words}w  %l:%c "

vim.bo.commentstring = "<!-- %s -->"

vim.api.nvim_buf_create_user_command(0, "MDTableFormat", function()
	require("user.table").format()
end, { desc = "Format markdown table under cursor" })

vim.api.nvim_buf_create_user_command(0, "MDNextHeading", function()
	require("markdown.nav").next_heading()
end, { desc = "Go to next heading" })

vim.api.nvim_buf_create_user_command(0, "MDPrevHeading", function()
	require("markdown.nav").prev_heading()
end, { desc = "Go to previous heading" })
