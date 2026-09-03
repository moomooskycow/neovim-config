-- Lean keymaps: raw markdown, Goyo auto, Ember.

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map({ "n", "v" }, "<Space>", "<Nop>", opts)

-- windows
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- buffers
map("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Prev buffer" })
map("n", "<leader>bd", "<cmd>bp|bd #<CR>", { desc = "Delete buffer" })

-- soft-wrap motion
map({ "n", "v" }, "j", "gj", opts)
map({ "n", "v" }, "k", "gk", opts)
map({ "n", "v" }, "0", "g0", opts)
map({ "n", "v" }, "$", "g$", opts)

-- move lines
map("n", "<A-j>", "<cmd>m .+1<CR>==", opts)
map("n", "<A-k>", "<cmd>m .-2<CR>==", opts)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- clear search
map("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

-- files
map("n", "<leader>e", "<cmd>Oil<CR>", { desc = "File browser" })
map("n", "<leader>ff", function()
	require("telescope.builtin").find_files()
end, { desc = "Find files" })
map("n", "<leader>fg", function()
	require("telescope.builtin").live_grep()
end, { desc = "Live grep" })
map("n", "<leader>fb", function()
	require("telescope.builtin").buffers()
end, { desc = "Buffers" })
map("n", "<leader>fh", function()
	require("telescope.builtin").help_tags()
end, { desc = "Help" })
map("n", "<leader><leader>", function()
	require("telescope.builtin").find_files()
end, { desc = "Find files" })

-- motion
map("n", "<leader>o", "<cmd>HopWord<CR>", { desc = "Hop word" })
map("n", "<leader>l", "<cmd>HopLine<CR>", { desc = "Hop line" })

-- writing: Goyo default
map("n", "<leader>z", "<cmd>Goyo<CR>", { desc = "Goyo" })
map("n", "<leader>gy", "<cmd>Goyo<CR>", { desc = "Goyo" })
map("n", "<leader>th", function()
	local bg = vim.o.background == "dark" and "light" or "dark"
	vim.o.background = bg
	vim.cmd.colorscheme("ember")
	vim.notify("Theme: " .. bg .. " (ember " .. (bg == "light" and "dawn" or "ink") .. ")", vim.log.levels.INFO)
end, { desc = "Toggle light/dark" })
map("n", "<leader>ss", function()
	vim.opt_local.spell = not vim.opt_local.spell:get()
	vim.notify("Spell: " .. (vim.opt_local.spell:get() and "on" or "off"), vim.log.levels.INFO)
end, { desc = "Toggle spell" })

-- save / quit
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Write" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit" })
