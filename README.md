# my-vimrc

The standard vimrc I use. This project is just for keeping an online copy and easy access from other workstataions.

## 1. Installation

### Basic
```
cd ~
git clone https://github.com/tinkerbeast/my-vimrc.git .vim
ln -s .vim/vimrc .vimrc
```
### Static plugins
```
mkdir -p ~/.vim/autoload/
mkdir -p ~/.vim/plugin/
curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -fLo ~/.vim/plugin/cscope_maps.vim http://cscope.sourceforge.net/cscope_maps.vim
```
### Plug base plugins
```
:PlugInstall
```

## 2. Vim vs Neovim

One file serves both. The differences:
- **Vim only:** vim-polyglot (extra language syntax), cscope, the cursor-shape escape codes, the Alt-key setup. Neovim has its own built-in versions of the rest.
- EditorConfig is built in to Neovim 0.9+ and Vim 9.0.1776+; older Vim gets it from a plugin.

## 3. Find things

| Keys | Does |
|------|------|
| `Ctrl-p` | Fuzzy-find a file (`:Files`) |
| `\b` | Fuzzy-pick an open buffer |
| `\/` | Search text in the project (types `:Rg ` for you; then type the pattern) |
| `Ctrl-n` / `\n` | File tree toggle / reveal the current file in the tree |
| `F8` | Outline of the current file (needs `ctags`) |

In any fuzzy list: `Enter` opens, `Ctrl-t` opens in a new tab, `Ctrl-x` in a split, `Ctrl-v` in a vertical split, `Tab` marks several.

`:Rg <pattern>` takes a **pattern only**. Flags such as `-i` or `-g '*.c'` are not passed to `rg`. For a live-updating search use `:RG`.

## 4. Edits

| Keys | Does |
|------|------|
| `Alt-j` / `Alt-k` | Move the line (or selection) down / up |
| `Space` | Toggle the fold under the cursor (otherwise moves right). Everything starts unfolded |
| `\zi` `\zs` `\zm` | Fold by indent (default) / syntax / by hand. `zM` closes all, `zR` opens all |
| `Ctrl-j` / `Ctrl-k` | Scroll one line down / up |
| `*` in Visual mode | Search for the selected text |
| `Tab` after a snippet name | Expand it (`for<Tab>`, `if<Tab>`, ...). `Tab` / `Shift-Tab` jump between the blanks |
| `\y` in Visual mode | Copy the selected **lines** to the system clipboard (only when your Vim has no `+clipboard`; needs `wl-copy`, `xclip`, `xsel`, `clip.exe` or `pbcopy`) |

- Indentation is 4 spaces by default; a project's `.editorconfig` overrides it automatically.
- Trailing whitespace is removed on save for `*.py *.c *.h *.cc *.cpp *.hpp`. Saving an old file can therefore produce whitespace-only changes in your diff. To switch it off, add `autocmd! trim_ws` **after** the `source` line.

## 5. Tabs and buffers

| Keys | Does |
|------|------|
| `\tn` | New tab |
| `\te` | New tab, prompted with the current file's directory |
| `\ts` | Open the current file in a new tab |
| `\tb` | Put every open buffer in its own tab |
| `\1` ... `\9`, `\0` | Go to tab 1-9 / first tab |
| `\tt` | Back to the previously used tab |
| `:Bclose` | Close the buffer but keep the window |

## 6. Small helpers

| Keys | Does |
|------|------|
| `\<Tab>` | Show / hide whitespace and tabs |
| `\<Enter>` | Clear search highlight |
| `\cd` | `cd` to the current file's directory |
| `\ss` | Spell check on/off. `\sn` / `\sp` next / previous, `\sa` add word, `\s?` suggestions |
| `\m` | Remove Windows `^M` line endings |
| `\q` / `\x` | Scratch buffer `~/buffer` / `~/buffer.md` |

## 7. Lint errors

- Linting runs when you **open** a file and when you **save** it. It does not run while you type.
- Problems appear as `E` / `W` in the sign column. Put the cursor on the line to see the message in the command line.
- C/C++ without a `compile_commands.json` often reports "file not found" for headers. Generate one: `cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=ON`, `bear -- make`, or in the Linux kernel `scripts/clang-tools/gen_compile_commands.py`. Put it in the project root.

## 8. Troubleshooting

| Symptom | Fix |
|---------|-----|
| Garbled or wrong colours | `let g:vimrc_truecolor = 0`. Try this first if you use `solarized`, which predates 24-bit colour |
| Colours wrong only inside tmux | In `~/.tmux.conf`: `set -as terminal-features ',*:RGB'` (older tmux: `set -ga terminal-overrides ',*:Tc'`) |
| `Alt-j` / `Alt-k` do nothing | Your terminal must send Alt as Esc. macOS Terminal: *Use Option as Meta key*. iTerm2: *Left Option key: Esc+* |
| `E185` for a colorscheme | Run `:PlugInstall`, or pick a name from the list at the top of the vimrc |
| Snippets do nothing | They need Python 3: check `:echo has('python3')` prints 1. Neovim also needs `pynvim` (`sudo apt install python3-pynvim` or `pip install pynvim`) |
| Neovim shows an "UltiSnips Python diagnostics" window at start | Same cause. Install `pynvim` or set `g:vimrc_ultisnips = 0` |
| No lint markers | `:ALEInfo` - is the linter listed as enabled, and is its tool installed? |
| `\/` does nothing | Install `ripgrep` (see section 1) |
| Many files are missing from `Ctrl-p` | fzf will still read files mentioned in `.gitignore` unless told: `export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'` in your shell rc |



