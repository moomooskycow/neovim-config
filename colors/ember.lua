-- Ember / Ember Dawn — matches Ghostty themes of the same name.
-- Applied via colorscheme ember; background light|dark selects the pole.

local function hi(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

local dark = {
	bg = "#131119",
	bg_alt = "#1c1820",
	bg_lift = "#2a2430",
	fg = "#d5cec4",
	fg_dim = "#9a9288",
	fg_mute = "#6f6878",
	line = "#4a4458",
	amber = "#e8a849",
	gold = "#d4a54c",
	blue = "#7a9ec2",
	teal = "#7aab9c",
	green = "#8aab7c",
	red = "#d46a6a",
	rose = "#e88888",
	select = "#3d2e1f",
	cursor = "#e8a849",
}

local light = {
	bg = "#f4efe8",
	bg_alt = "#e8e0d4",
	bg_lift = "#ddd3c4",
	fg = "#2c2622",
	fg_dim = "#5a5248",
	fg_mute = "#7a6f63",
	line = "#cfc3b2",
	amber = "#c47a2a",
	gold = "#8a641a",
	blue = "#4a6a8a",
	teal = "#2f5a4c",
	green = "#5a7a4c",
	red = "#b04040",
	rose = "#c25050",
	select = "#e4d4be",
	cursor = "#c47a2a",
}

local c = vim.o.background == "light" and light or dark

vim.cmd("highlight clear")
if vim.fn.exists("syntax_on") == 1 then
	vim.cmd("syntax reset")
end
vim.g.colors_name = "ember"

hi("Normal", { fg = c.fg, bg = c.bg })
hi("NormalFloat", { fg = c.fg, bg = c.bg_alt })
hi("FloatBorder", { fg = c.line, bg = c.bg_alt })
hi("NormalNC", { fg = c.fg, bg = c.bg })
hi("Cursor", { fg = c.bg, bg = c.cursor })
hi("CursorLine", { bg = c.bg_alt })
hi("CursorColumn", { bg = c.bg_alt })
hi("ColorColumn", { bg = c.bg_alt })
hi("Visual", { bg = c.select })
hi("VisualNOS", { bg = c.select })
hi("Search", { fg = c.bg, bg = c.gold })
hi("IncSearch", { fg = c.bg, bg = c.amber })
hi("CurSearch", { fg = c.bg, bg = c.amber })
hi("MatchParen", { fg = c.amber, bold = true })
hi("LineNr", { fg = c.fg_mute })
hi("CursorLineNr", { fg = c.amber, bold = true })
hi("SignColumn", { fg = c.fg_mute, bg = c.bg })
hi("Folded", { fg = c.fg_dim, bg = c.bg_alt })
hi("FoldColumn", { fg = c.fg_mute, bg = c.bg })
hi("StatusLine", { fg = c.fg, bg = c.bg_alt })
hi("StatusLineNC", { fg = c.fg_mute, bg = c.bg_alt })
hi("WinSeparator", { fg = c.line })
hi("VertSplit", { fg = c.line })
hi("TabLine", { fg = c.fg_dim, bg = c.bg_alt })
hi("TabLineSel", { fg = c.amber, bg = c.bg, bold = true })
hi("TabLineFill", { bg = c.bg_alt })
hi("Pmenu", { fg = c.fg, bg = c.bg_alt })
hi("PmenuSel", { fg = c.bg, bg = c.amber })
hi("PmenuSbar", { bg = c.bg_lift })
hi("PmenuThumb", { bg = c.line })
hi("WildMenu", { fg = c.bg, bg = c.amber })
hi("Question", { fg = c.amber })
hi("MoreMsg", { fg = c.green })
hi("ModeMsg", { fg = c.fg, bold = true })
hi("ErrorMsg", { fg = c.red, bold = true })
hi("WarningMsg", { fg = c.gold })
hi("Title", { fg = c.amber, bold = true })
hi("Directory", { fg = c.blue })
hi("NonText", { fg = c.line })
hi("SpecialKey", { fg = c.line })
hi("Whitespace", { fg = c.line })
hi("EndOfBuffer", { fg = c.bg })
hi("Conceal", { fg = c.fg_mute })
hi("Underlined", { fg = c.blue, underline = true })
hi("Bold", { bold = true })
hi("Italic", { italic = true })
hi("Todo", { fg = c.amber, bold = true })
hi("Comment", { fg = c.fg_dim, italic = true })
hi("Constant", { fg = c.rose })
hi("String", { fg = c.rose })
hi("Character", { fg = c.rose })
hi("Number", { fg = c.green })
hi("Boolean", { fg = c.amber })
hi("Float", { fg = c.green })
hi("Identifier", { fg = c.teal })
hi("Function", { fg = c.gold })
hi("Statement", { fg = c.blue })
hi("Conditional", { fg = c.blue })
hi("Repeat", { fg = c.blue })
hi("Label", { fg = c.blue })
hi("Operator", { fg = c.fg_dim })
hi("Keyword", { fg = c.blue, italic = true })
hi("Exception", { fg = c.red })
hi("PreProc", { fg = c.amber })
hi("Include", { fg = c.blue })
hi("Define", { fg = c.blue })
hi("Macro", { fg = c.amber })
hi("Type", { fg = c.amber })
hi("StorageClass", { fg = c.amber })
hi("Structure", { fg = c.amber })
hi("Typedef", { fg = c.amber })
hi("Special", { fg = c.gold })
hi("SpecialChar", { fg = c.gold })
hi("Tag", { fg = c.blue })
hi("Delimiter", { fg = c.fg_dim })
hi("SpecialComment", { fg = c.fg_dim, italic = true })
hi("Debug", { fg = c.red })
hi("Error", { fg = c.red })
hi("DiffAdd", { fg = c.green, bg = c.bg_alt })
hi("DiffChange", { fg = c.gold, bg = c.bg_alt })
hi("DiffDelete", { fg = c.red, bg = c.bg_alt })
hi("DiffText", { fg = c.amber, bg = c.select })
hi("DiagnosticError", { fg = c.red })
hi("DiagnosticWarn", { fg = c.gold })
hi("DiagnosticInfo", { fg = c.blue })
hi("DiagnosticHint", { fg = c.teal })
hi("DiagnosticOk", { fg = c.green })
hi("DiagnosticUnderlineError", { sp = c.red, undercurl = true })
hi("DiagnosticUnderlineWarn", { sp = c.gold, undercurl = true })
hi("DiagnosticUnderlineInfo", { sp = c.blue, undercurl = true })
hi("DiagnosticUnderlineHint", { sp = c.teal, undercurl = true })
hi("GitSignsAdd", { fg = c.green })
hi("GitSignsChange", { fg = c.gold })
hi("GitSignsDelete", { fg = c.red })
hi("TelescopeNormal", { fg = c.fg, bg = c.bg_alt })
hi("TelescopeBorder", { fg = c.line, bg = c.bg_alt })
hi("TelescopeSelection", { bg = c.select })
hi("TelescopeMatching", { fg = c.amber, bold = true })
hi("OilDir", { fg = c.blue, bold = true })
hi("OilFile", { fg = c.fg })
hi("markdownH1", { fg = c.amber, bold = true })
hi("markdownH2", { fg = c.gold, bold = true })
hi("markdownH3", { fg = c.blue, bold = true })
hi("markdownCode", { fg = c.gold })
hi("markdownCodeBlock", { fg = c.fg })
hi("markdownLinkText", { fg = c.blue, underline = true })
hi("@comment", { link = "Comment" })
hi("@keyword", { link = "Keyword" })
hi("@function", { link = "Function" })
hi("@string", { link = "String" })
hi("@number", { link = "Number" })
hi("@type", { link = "Type" })
hi("@variable", { fg = c.teal })
hi("@constant", { link = "Constant" })
hi("@punctuation", { link = "Delimiter" })
