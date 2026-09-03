-- Markdown writing kit: Ember light, raw, Goyo by default.

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local function system_bg()
	-- 1. Omarchy theme
	local omarchy_theme = vim.fn.expand("~/.local/state/omarchy/current/theme/colors.toml")
	local f = io.open(omarchy_theme, "r")
	if f then
		local content = f:read("*a")
		f:close()
		local mode = content:match('mode%s*=%s*["\']?(%w+)["\']?')
		if mode == "dark" or mode == "light" then
			return mode
		end
	end

	-- 2. macOS appearance
	if vim.fn.has("mac") == 1 then
		local out = vim.fn.system("defaults read -g AppleInterfaceStyle 2>/dev/null")
		if vim.v.shell_error == 0 and out:match("Dark") then
			return "dark"
		end
	end

	return "light"
end

-- Ember lives in colors/ember.lua (Ghostty Ember / Ember Dawn poles).
vim.o.background = system_bg()
vim.cmd.colorscheme("ember")

require("lazy").setup({
	-- syntax (nvim 0.12 needs main)
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")
			ts.setup({
				install_dir = vim.fn.stdpath("data") .. "/site",
			})
			local installed = {}
			for _, lang in ipairs(ts.get_installed()) do
				installed[lang] = true
			end
			local to_install = {}
			for _, lang in ipairs({ "markdown", "markdown_inline", "yaml", "html", "lua" }) do
				if not installed[lang] then
					table.insert(to_install, lang)
				end
			end
			if #to_install > 0 then
				ts.install(to_install)
			end

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "markdown", "lua", "yaml", "html" },
				callback = function()
					pcall(vim.treesitter.start)
				end,
			})
		end,
	},

	-- heading / checkbox / table helpers (no conceal)
	{
		"tadmccorkle/markdown.nvim",
		ft = "markdown",
		opts = {
			mappings = {
				go_curr_heading = false,
				go_parent_heading = false,
			},
		},
	},
	-- Goyo: default on for markdown, robust auto-enter
	{
		"junegunn/goyo.vim",
		lazy = false,
		keys = {
			{ "<leader>z", "<cmd>Goyo<CR>", desc = "Goyo" },
			{ "<leader>gy", "<cmd>Goyo<CR>", desc = "Goyo" },
		},
		init = function()
			vim.g.goyo_width = 80
			vim.g.goyo_height = "100%"
			vim.g.goyo_linenr = 0

			local function try_enter()
				if #vim.api.nvim_list_uis() == 0 then
					return
				end
				if vim.t.goyo_master then
					return
				end
				if vim.bo.filetype ~= "markdown" then
					return
				end
				if vim.fn.exists(":Goyo") ~= 2 then
					return
				end
				if vim.api.nvim_win_get_config(0).relative ~= "" then
					return
				end
				vim.defer_fn(function()
					if vim.t.goyo_master then
						return
					end
					if vim.bo.filetype == "markdown" then
						pcall(vim.cmd, "silent! Goyo")
					end
				end, 100)
			end

			local group = vim.api.nvim_create_augroup("GoyoAuto", { clear = true })

			vim.api.nvim_create_autocmd("FileType", {
				group = group,
				pattern = "markdown",
				callback = try_enter,
			})

			vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
				group = group,
				pattern = { "*.md", "*.markdown", "*.mdx" },
				callback = function()
					vim.defer_fn(try_enter, 150)
				end,
			})

			vim.api.nvim_create_autocmd("VimEnter", {
				group = group,
				callback = function()
					vim.defer_fn(try_enter, 200)
				end,
			})
			vim.api.nvim_create_autocmd("User", {
				group = group,
				pattern = "GoyoEnter",
				callback = function()
					local bg = vim.o.background == "dark" and "#16141d" or "#f5f0e8"
					vim.cmd("highlight NormalNC guibg=" .. bg)
					vim.cmd("highlight EndOfBuffer guifg=" .. bg .. " guibg=" .. bg)
					vim.cmd("highlight SignColumn guibg=" .. bg)
					vim.cmd("highlight FoldColumn guibg=" .. bg)
					vim.cmd("highlight StatusLine guibg=" .. bg .. " gui=NONE")
					vim.cmd("highlight StatusLineNC guibg=" .. bg .. " gui=NONE")
				end,
			})

			vim.api.nvim_create_autocmd("User", {
				group = group,
				pattern = "GoyoLeave",
				callback = function()
					vim.cmd.colorscheme("ember")
				end,
			})
		end,
	},

	-- file browser
	{
		"stevearc/oil.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			view_options = { show_hidden = true },
			keymaps = {
				["q"] = "actions.close",
				["<C-c>"] = "actions.close",
			},
			float = { padding = 2, max_width = 80, max_height = 30 },
		},
	},

	-- fuzzy find notes
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			defaults = {
				prompt_prefix = "  ",
				selection_caret = "› ",
				sorting_strategy = "ascending",
				layout_config = { prompt_position = "top" },
				file_ignore_patterns = { "node_modules", ".git/", "lazy%-lock%.json" },
			},
			pickers = {
				find_files = { hidden = true },
			},
		},
	},

	-- hop around long docs
	{
		"smoka7/hop.nvim",
		version = "*",
		cmd = { "HopWord", "HopLine", "HopChar1" },
		opts = { keys = "etovxqpdygfblzhckisuran" },
	},

	-- surround for **bold**, `code`, links
	{ "kylechui/nvim-surround", event = "VeryLazy", opts = {} },

	-- icons for oil/telescope
	{ "nvim-tree/nvim-web-devicons", lazy = true },
}, {
	install = { colorscheme = { "ember" } },
	checker = { enabled = false },
	change_detection = { notify = false },
	performance = {
		rtp = {
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
				"rplugin",
				"spellfile",
			},
		},
	},
	ui = { border = "rounded" },
})
