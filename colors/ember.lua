-- Ember / Ember Dawn — matches Ghostty themes of the same name.
-- Applied via colorscheme ember; background light|dark selects the pole.

local function hi(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

local dark = {
	bg = "#16141d",
	bg_alt = "#1f1b26",
	bg_lift = "#2b2535",
	fg = "#e6dfd5",
	fg_dim = "#a8a096",
	fg_mute = "#726b7c",
	line = "#3f3749",
	amber = "#f0a842",
	gold = "#e5b558",
	blue = "#82aaff",
	teal = "#7bc2ad",
	green = "#9ecc88",
	red = "#e06c75",
	rose = "#f08d8d",
	select = "#3a2c20",
	cursor = "#f0a842",
	code_bg = "#221d28",
}

local light = {
	bg = "#f5f0e8",
	bg_alt = "#eae1d5",
	bg_lift = "#ded3c3",
	fg = "#2c2622",
	fg_dim = "#5a5248",
	fg_mute = "#887d70",
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
	code_bg = "#ece4d6",
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
-- Markdown syntax (classic Vim)
hi("markdownH1", { fg = c.amber, bold = true })
hi("markdownH2", { fg = c.gold, bold = true })
hi("markdownH3", { fg = c.blue, bold = true })
hi("markdownH4", { fg = c.teal, bold = true })
hi("markdownH5", { fg = c.green, bold = true })
hi("markdownH6", { fg = c.rose, bold = true })
hi("markdownHeadingDelimiter", { fg = c.fg_mute })
hi("markdownCode", { fg = c.gold, bg = c.code_bg })
hi("markdownCodeBlock", { fg = c.fg, bg = c.bg_alt })
hi("markdownCodeDelimiter", { fg = c.fg_mute })
hi("markdownLinkText", { fg = c.blue, underline = true })
hi("markdownUrl", { fg = c.fg_mute })
hi("markdownListMarker", { fg = c.amber })
hi("markdownOrderedListMarker", { fg = c.amber })
hi("markdownRule", { fg = c.line, bold = true })
hi("markdownBlockquote", { fg = c.fg_dim, italic = true })
hi("markdownBold", { fg = c.fg, bold = true })
hi("markdownItalic", { fg = c.fg_dim, italic = true })

-- Treesitter Markdown & Markup
hi("@markup.heading", { bold = true })
hi("@markup.heading.1", { fg = c.amber, bold = true })
hi("@markup.heading.2", { fg = c.gold, bold = true })
hi("@markup.heading.3", { fg = c.blue, bold = true })
hi("@markup.heading.4", { fg = c.teal, bold = true })
hi("@markup.heading.5", { fg = c.green, bold = true })
hi("@markup.heading.6", { fg = c.rose, bold = true })
hi("@markup.heading.1.markdown", { fg = c.amber, bold = true })
hi("@markup.heading.2.markdown", { fg = c.gold, bold = true })
hi("@markup.heading.3.markdown", { fg = c.blue, bold = true })
hi("@markup.heading.4.markdown", { fg = c.teal, bold = true })
hi("@markup.heading.5.markdown", { fg = c.green, bold = true })
hi("@markup.heading.6.markdown", { fg = c.rose, bold = true })
hi("@markup.heading.marker", { fg = c.fg_mute })

hi("@markup.strong", { fg = c.fg, bold = true })
hi("@markup.italic", { fg = c.fg_dim, italic = true })
hi("@markup.strikethrough", { fg = c.fg_mute, strikethrough = true })

hi("@markup.raw", { fg = c.gold, bg = c.code_bg })
hi("@markup.raw.markdown_inline", { fg = c.gold, bg = c.code_bg })
hi("@markup.raw.block.markdown", { fg = c.fg, bg = c.bg_alt })
hi("@markup.raw.delimiter.markdown", { fg = c.fg_mute })

hi("@markup.link", { fg = c.blue })
hi("@markup.link.label", { fg = c.blue, underline = true })
hi("@markup.link.label.markdown_inline", { fg = c.blue, underline = true })
hi("@markup.link.url", { fg = c.fg_mute, underline = false })

hi("@markup.list", { fg = c.amber })
hi("@markup.list.markdown", { fg = c.amber })
hi("@markup.list.checked", { fg = c.green, bold = true })
hi("@markup.list.unchecked", { fg = c.fg_mute })

hi("@markup.quote", { fg = c.fg_dim, italic = true })
hi("@markup.quote.markdown", { fg = c.fg_dim, italic = true })

hi("@markup.thematic_break", { fg = c.line, bold = true })
hi("@markup.thematic_break.markdown", { fg = c.line, bold = true })

hi("@punctuation.special.markdown", { fg = c.fg_mute })
hi("@punctuation.delimiter.markdown", { fg = c.fg_mute })
hi("@punctuation.bracket.markdown_inline", { fg = c.fg_mute })

-- General Treesitter links
hi("@comment", { link = "Comment" })
hi("@keyword", { link = "Keyword" })
hi("@function", { link = "Function" })
hi("@string", { link = "String" })
hi("@number", { link = "Number" })
hi("@type", { link = "Type" })
hi("@variable", { fg = c.teal })
hi("@constant", { link = "Constant" })
hi("@punctuation", { link = "Delimiter" })

-- Distraction-free writing (Goyo)
hi("GoyoBackground", { fg = c.fg, bg = c.bg })
