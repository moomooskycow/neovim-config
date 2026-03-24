local M = {}

function M.setup()
	-- disable supermaven when in markdown files
	local supermaven_api -- cache to avoid repeated require
	vim.api.nvim_create_autocmd("BufEnter", {
		pattern = "*.md",
		callback = function()
			if supermaven_api == nil then
				local ok, api = pcall(require, "supermaven-nvim.api")
				supermaven_api = ok and api or false
			end
			if supermaven_api and supermaven_api.is_running() then
				vim.cmd("SupermavenStop")
			end
		end,
	})

	-- text files
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "text",
		command = "setlocal wrap linebreak nolist",
	})
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "text",
		callback = function()
			vim.keymap.set("n", "j", "gj", { buffer = true })
			vim.keymap.set("n", "k", "gk", { buffer = true })
		end,
	})

	-- remove trailing whitespace
	vim.api.nvim_create_autocmd({ "BufWritePre" }, {
		pattern = { "*" },
		command = [[%s/\s\+$//e]],
	})


	-- Autocommands for Lua and Rust files
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*.lua,*.rs,*.ts,*.tsx,*.js,*.jsx,*.svelte",
		callback = function()
			vim.lsp.buf.format()
		end,
	})

	-- format go code before save
	local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*.go",
		callback = function()
			require("go.format").goimports()
		end,
		group = format_sync_grp,
	})

	-- Lua configuration for Go formatting
	vim.api.nvim_create_augroup("Go", { clear = true })
	vim.api.nvim_create_autocmd("FileType", {
		group = "Go",
		pattern = "go",
		callback = function()
			vim.opt_local.expandtab = false
			vim.opt_local.tabstop = 4
			vim.opt_local.shiftwidth = 4
			vim.opt_local.softtabstop = 4
		end,
	})
	
	-- Ensure proper filetype for TSX files
	vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
		pattern = "*.tsx",
		callback = function()
			local current_ft = vim.bo.filetype
			vim.notify("TSX file detected: filetype=" .. current_ft, vim.log.levels.INFO)
			
			-- If filetype is not set correctly, fix it
			if current_ft ~= "typescriptreact" then
				vim.bo.filetype = "typescriptreact"
				vim.notify("Changed filetype to typescriptreact", vim.log.levels.INFO)
			end
		end,
	})
	
	-- Set .env files to use 'conf' filetype to avoid bash LSP warnings
	vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
		pattern = "*.env*",
		callback = function()
			vim.bo.filetype = "conf"
		end,
	})
end

return M
