-- Markdown buffer: raw, gorgeous, Goyo-ready, Omawrite-class writing kit.

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
opt.foldenable = true
opt.foldmethod = "manual"
opt.foldlevel = 0
opt.foldminlines = 0
opt.foldtext = [['---']]
opt.foldcolumn = "0"
opt.formatoptions:remove({ "t", "c" })
opt.statusline = "  %f %m  %=%{get(b:,'md_words','0')} words   %l:%c  "

vim.bo.commentstring = "<!-- %s -->"

-- Fold the opening YAML fence so writing starts at the title.
-- File stays raw (no conceal). za on the fold line opens the block.
local function frontmatter_end()
	local lines = vim.api.nvim_buf_get_lines(0, 0, 40, false)
	if lines[1] ~= "---" then
		return 0
	end
	for i = 2, #lines do
		if lines[i] == "---" then
			return i
		end
	end
	return 0
end


local function apply_frontmatter_fold()
	local last = frontmatter_end()
	if last > 0 then
		vim.opt_local.foldenable = true
		vim.opt_local.foldmethod = "manual"
		vim.opt_local.foldtext = [['---']]
		vim.opt_local.foldcolumn = "0"
		pcall(vim.cmd, "silent! 1," .. last .. "fold")
		pcall(vim.cmd, "silent! 1foldclose")

		if vim.api.nvim_win_get_cursor(0)[1] == 1 then
			local target = last + 1
			local count = vim.api.nvim_buf_line_count(0)
			while target <= count do
				local line = vim.api.nvim_buf_get_lines(0, target - 1, target, false)[1]
				if line ~= "" then
					break
				end
				target = target + 1
			end
			if target <= count then
				vim.api.nvim_win_set_cursor(0, { target, 0 })
			end
		end
	end
end

local function toggle_frontmatter_fold()
	local last = frontmatter_end()
	if last == 0 then
		return
	end
	if vim.fn.foldclosed(1) == -1 then
		pcall(vim.cmd, "silent! 1foldclose")
	else
		pcall(vim.cmd, "silent! 1foldopen!")
	end
end

vim.api.nvim_buf_create_user_command(0, "MDFrontmatter", toggle_frontmatter_fold, {
	desc = "Toggle YAML frontmatter fold",
})

apply_frontmatter_fold()

local function update_wordcount()
	local wc = vim.fn.wordcount()
	vim.b.md_words = wc.words or 0
end

update_wordcount()

local buf = vim.api.nvim_get_current_buf()
local group = vim.api.nvim_create_augroup("MarkdownPerf_" .. buf, { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
	group = group,
	buffer = buf,
	callback = function()
		update_wordcount()
	end,
})

if not vim.g.md_fm_goyo_hook then
	vim.g.md_fm_goyo_hook = true
	vim.api.nvim_create_autocmd("User", {
		pattern = "GoyoEnter",
		callback = function()
			if vim.bo.filetype == "markdown" then
				apply_frontmatter_fold()
			end
		end,
	})
end

-- Table formatter
vim.api.nvim_buf_create_user_command(0, "MDTableFormat", function()
	require("user.table").format()
end, { desc = "Format markdown table under cursor" })

-- Heading navigation with reliable treesitter + regex search fallback
local function next_heading()
	local ok, nav = pcall(require, "markdown.nav")
	local cur_row = vim.api.nvim_win_get_cursor(0)[1]
	if ok and nav and nav.next_heading then
		pcall(nav.next_heading)
	end
	if vim.api.nvim_win_get_cursor(0)[1] == cur_row then
		vim.fn.search([[^#\+\s]], "W")
	end
end

local function prev_heading()
	local ok, nav = pcall(require, "markdown.nav")
	local cur_row = vim.api.nvim_win_get_cursor(0)[1]
	if ok and nav and nav.prev_heading then
		pcall(nav.prev_heading)
	end
	if vim.api.nvim_win_get_cursor(0)[1] == cur_row then
		vim.fn.search([[^#\+\s]], "bW")
	end
end

vim.api.nvim_buf_create_user_command(0, "MDNextHeading", next_heading, {
	desc = "Go to next heading",
})

vim.api.nvim_buf_create_user_command(0, "MDPrevHeading", prev_heading, {
	desc = "Go to previous heading",
})

-- Checkbox toggle (handles - [ ] <-> - [x], converts - item -> - [ ] item, or adds - [ ])
local function toggle_checkbox()
	local line = vim.api.nvim_get_current_line()
	local changed
	line, changed = line:gsub("^(%s*[-*+]%s+)%[[xX]%]", "%1[ ]", 1)
	if changed == 0 then
		line, changed = line:gsub("^(%s*[-*+]%s+)%[%s%]", "%1[x]", 1)
	end
	if changed == 0 then
		line, changed = line:gsub("^(%s*[-*+]%s+)(.*)$", "%1[ ] %2", 1)
	end
	if changed == 0 then
		line = line:gsub("^(%s*)(.*)$", "%1- [ ] %2", 1)
	end
	vim.api.nvim_set_current_line(line)
end

vim.api.nvim_buf_create_user_command(0, "MDTaskToggle", toggle_checkbox, {
	desc = "Toggle markdown checkbox on current line",
})

-- Typewriter mode toggle (keeps cursor line centered vertically)
local function toggle_typewriter()
	if vim.wo.scrolloff >= 990 then
		vim.wo.scrolloff = 8
		vim.notify("Typewriter mode: off", vim.log.levels.INFO)
	else
		vim.wo.scrolloff = 999
		vim.notify("Typewriter mode: on", vim.log.levels.INFO)
	end
end

vim.api.nvim_buf_create_user_command(0, "MDTypewriter", toggle_typewriter, {
	desc = "Toggle typewriter scrolling mode",
})

-- Prose statistics (:MDStats)
vim.api.nvim_buf_create_user_command(0, "MDStats", function()
	local wc = vim.fn.wordcount()
	local words = wc.words or 0
	local chars = wc.chars or 0
	local reading_time = math.max(1, math.ceil(words / 200))
	local msg = string.format(" %d words  |  %d characters  |  ~%d min read ", words, chars, reading_time)
	vim.notify(msg, vim.log.levels.INFO, { title = "Document Stats" })
end, { desc = "Show markdown document statistics" })

-- Smart return: auto-continues lists/tasks/quotes, exits cleanly on empty item
vim.keymap.set("i", "<CR>", function()
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	local before_cursor = line:sub(1, col)

	-- Inside code fences, use standard return
	local row = vim.api.nvim_win_get_cursor(0)[1]
	local lines_before = vim.api.nvim_buf_get_lines(0, 0, row, false)
	local fence_count = 0
	for _, l in ipairs(lines_before) do
		if l:match("^%s*```") then
			fence_count = fence_count + 1
		end
	end
	if fence_count % 2 == 1 then
		return "\r"
	end

	-- Check for empty marker: only when the ENTIRE line is just the marker and whitespace
	local is_empty_line = line:match("^(%s*[-*+]%s+%[[%sxX]%])%s*$")
		or line:match("^(%s*[-*+])%s*$")
		or line:match("^(%s*%d+[.)])%s*$")
		or line:match("^(%s*>+)%s*$")

	if is_empty_line then
		return vim.api.nvim_replace_termcodes("<C-u>", true, false, true)
	end

	-- Task list item: - [ ] or - [x]
	local t_indent, t_bullet, t_task = before_cursor:match("^(%s*)([-*+])%s+%[[%sxX]%]%s+(.+)$")
	if t_indent and t_bullet and t_task then
		return "\r" .. t_indent .. t_bullet .. " [ ] "
	end

	-- Bullet list item: - or * or +
	local b_indent, b_bullet, b_content = before_cursor:match("^(%s*)([-*+])%s+(.+)$")
	if b_indent and b_bullet and b_content then
		return "\r" .. b_indent .. b_bullet .. " "
	end

	-- Numbered list: 1. or 1)
	local n_indent, n_num, n_sep, n_content = before_cursor:match("^(%s*)(%d+)([.)])%s+(.+)$")
	if n_indent and n_num and n_sep and n_content then
		local next_n = tonumber(n_num) + 1
		return "\r" .. n_indent .. tostring(next_n) .. n_sep .. " "
	end

	-- Blockquote: >
	local q_indent, q_mark, q_content = before_cursor:match("^(%s*)(>+)%s+(.+)$")
	if q_indent and q_mark and q_content then
		return "\r" .. q_indent .. q_mark .. " "
	end

	return "\r"
end, { expr = true, buffer = true, desc = "Smart markdown list continuation" })

-- Smart link helper
local function smart_link()
	local clip = vim.fn.getreg("+"):gsub("^%s+", ""):gsub("%s+$", "")
	local is_url = clip:match("^https?://") or clip:match("^www%.")
	if is_url and clip:match("^www%.") then
		clip = "https://" .. clip
	end
	local url = is_url and clip or "https://"

	local mode = vim.fn.mode()
	if mode:match("[vV\22]") then
		-- Exit visual mode so '< and '> marks are set to the visual range
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)
		local _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
		local _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
		local lines = vim.api.nvim_buf_get_text(0, csrow - 1, cscol - 1, cerow - 1, cecol, {})
		local selected = table.concat(lines, " ")
		local replacement = string.format("[%s](%s)", selected, url)
		vim.api.nvim_buf_set_text(0, csrow - 1, cscol - 1, cerow - 1, cecol, { replacement })
		vim.api.nvim_win_set_cursor(0, { csrow, cscol - 1 + #replacement })
	else
		local template = string.format("[](%s)", url)
		vim.api.nvim_put({ template }, "c", true, true)
		local pos = vim.api.nvim_win_get_cursor(0)
		vim.api.nvim_win_set_cursor(0, { pos[1], math.max(0, pos[2] - #url - 2) })
		vim.cmd("startinsert")
	end
end

vim.api.nvim_buf_create_user_command(0, "MDLink", smart_link, {
	desc = "Insert markdown link or wrap selection with clipboard URL",
})

-- Buffer-local shortcuts
vim.keymap.set("n", "]]", next_heading, { buffer = true, desc = "Next heading" })
vim.keymap.set("n", "[[", prev_heading, { buffer = true, desc = "Prev heading" })
vim.keymap.set("n", "<leader>x", toggle_checkbox, { buffer = true, desc = "Toggle checkbox" })
vim.keymap.set("n", "<leader>mt", toggle_checkbox, { buffer = true, desc = "Toggle checkbox" })
vim.keymap.set("n", "<leader>mf", function() require("user.table").format() end, { buffer = true, desc = "Format table" })
vim.keymap.set("n", "<leader>mk", smart_link, { buffer = true, desc = "Insert link" })
vim.keymap.set("v", "<leader>mk", smart_link, { buffer = true, desc = "Wrap selection as link" })
vim.keymap.set("n", "<leader>tw", toggle_typewriter, { buffer = true, desc = "Toggle typewriter mode" })
vim.keymap.set("n", "<leader>ms", "<cmd>MDStats<CR>", { buffer = true, desc = "Show document stats" })
vim.keymap.set("n", "<leader>fy", toggle_frontmatter_fold, { buffer = true, desc = "Toggle frontmatter fold" })
