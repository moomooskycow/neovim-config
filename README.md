# Neovim — Markdown Writing Kit

Fast, clean, gorgeous. Raw markdown only.

## Stack

| Plugin | Role |
|--------|------|
| **ember** | Dawn light default (system-aware), toggle `<leader>th` |
| **goyo.vim** | Distraction-free, **auto-enters** on markdown |
| **markdown.nvim** | Heading nav `]]`/`[[`, checkbox, table format |
| **oil.nvim** | File browser `<leader>e` |
| **telescope** | Find files / live grep |
| **hop.nvim** | Jump by word/line |
| **nvim-surround** | `**bold**`, `` `code` ``, links |
| **treesitter** | Markdown + frontmatter only |

No rendered markdown. No conceal. No newline glyphs. No LSP.

## Theme

- Default: **ember dawn** (light) / ink (dark)
- Auto-detects macOS appearance via `defaults read -g AppleInterfaceStyle`
- Toggle: `<leader>th`

## Keybindings

| Key | Action |
|-----|--------|
| `<leader>z` | Goyo toggle |
| `<leader>th` | Toggle light/dark |
| `<leader>ss` | Toggle spell |
| `<leader>ff` / `<leader><leader>` | Find files |
| `<leader>fg` | Live grep |
| `<leader>fb` | Buffers |
| `<leader>e` | Oil |
| `]]` / `[[` | Next / prev heading |
| `<leader>mt` | Toggle checkbox |
| `<leader>mf` | Format table |
| `<leader>o` / `<leader>l` | Hop word / line |
| `j` / `k` | Wrapped-line motion |
| `<leader>w` / `<leader>q` | Write / quit |

## Behavior

- Opens markdown → auto Goyo (80 cols, centered, no line numbers)
- Raw view: `conceallevel=0`, `showbreak=""`, `list=false` — no ↳ or hidden chars
- Background `light` by default, word count in minimal statusline

## Layout

```
init.lua
lua/user/
  options.lua
  keymaps.lua
  plugins.lua
after/ftplugin/markdown.lua
```
