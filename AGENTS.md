# Neovim Configuration Guidelines

Markdown-only writing kit. Raw view, Ember light default, Goyo auto.

## Commands
- **Plugins**: lazy.nvim (`:Lazy`)
- **Treesitter**: markdown, markdown_inline, yaml, html, lua (main branch, 0.12 compat)
- **Render**: none — conceallevel=0, showbreak="", list=false

## Style
- Lua: tabs, ~100 cols, snake_case
- Modules: lua/user/* — keep minimal
- Keymaps: vim.keymap.set() silent/noremap
- Theme: Ember / Ember Dawn (colors/ember.lua); system dark detection via defaults read; toggle <leader>th
- Goyo: width 80, linenr 0, auto-enter on markdown (FileType + BufReadPost *.md + VimEnter), toggle <leader>z

## Layout
- init.lua — loader
- lua/user/options.lua — raw, light, no glyphs
- lua/user/keymaps.lua — Goyo + Ember light/dark toggle
- lua/user/plugins.lua — 11-plugin kit
- after/ftplugin/markdown.lua — raw prose

## Scope
- Keep only raw markdown reading/writing aids
- Reject rendered plugins, conceal, LSP, completion, AI, heavy UI
- Prefer Goyo, soft wrap, raw, telescope, oil

## Principles
- Conventional Commits, atomic, simplicity first — delete before adding
