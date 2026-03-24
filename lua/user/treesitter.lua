local M = {}

function M.setup()
	local status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
	if not status_ok then
		return
	end
	
	-- Configure TreeSitter installation parameters for proper ARM64 compilation
	local ts_install = require("nvim-treesitter.install")
	ts_install.prefer_git = true
	ts_install.compilers = { "clang" }

	-- Arch mismatch fix: run manually with :TSFixArch if parsers misbehave.
	-- Removed from startup — was spawning 13 subprocesses synchronously.
	vim.api.nvim_create_user_command("TSFixArch", function()
		local arch = vim.fn.system("uname -m"):gsub("\n", "")
		if arch ~= "arm64" then
			vim.notify("Not on arm64, nothing to do", vim.log.levels.INFO)
			return
		end
		local parser_dir = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/parser/"
		local parsers = {
			"bash", "lua", "python", "javascript", "typescript", "tsx",
			"html", "css", "json", "yaml", "toml", "go", "rust",
		}
		for _, name in ipairs(parsers) do
			local path = parser_dir .. name .. ".so"
			if vim.fn.filereadable(path) == 1 then
				local info = vim.fn.system("file " .. path)
				if info:match("x86_64") then
					vim.fn.delete(path)
					vim.cmd("TSInstall " .. name)
					vim.notify("Reinstalling " .. name .. " for arm64", vim.log.levels.INFO)
				end
			end
		end
	end, { desc = "Fix treesitter parsers compiled for wrong architecture" })

	treesitter.setup({
		ensure_installed = {
			"lua",
			"markdown",
			"markdown_inline",
			"bash",
			"javascript",
			"typescript",
			"tsx",
			"latex", -- Added for render-markdown.nvim LaTeX support
			"html",  -- Added for render-markdown.nvim HTML comment support
		},
		sync_install = false, -- Don't force synchronous installation
		auto_install = false, -- Disable auto-install to prevent reinstallation
		highlight = { 
			enable = true,
			-- Disable highlighting for gitignore files to prevent parser errors in Neovim 0.11.0
			disable = function(lang, bufnr)
				local filename = vim.fn.expand("%:t")
				return (lang == "gitignore" or (filename == ".gitignore" and lang == "gitignore"))
			end
		},
		indent = { enable = true },
	})
end

return M