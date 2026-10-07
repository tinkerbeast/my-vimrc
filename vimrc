"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This file is adapted from github.com/amix/vimrc
"
" References
"  Moving in vim - vim.wikia.com/wiki/All_the_right_moves
"  Tabs in vim - vim.wikia.com/wiki/Using_tab_pages
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Per-user switches (shared vimrc)
" --------------------------------
" Everyone can override these WITHOUT editing this file: put the `let` in your
" own ~/.vimrc (or init.vim) BEFORE sourcing this file, e.g.
"     let g:vimrc_colorscheme = 'sonokai'
"     source /path/to/this/vimrc
" Or just edit the defaults below in your own copy.
"
"   g:vimrc_colorscheme  Colorscheme to start with. Installed choices:
"                        gruvbox-material (default), sonokai, codedark,
"                        onedark, molokai, solarized, jellybeans, zenburn.
"                        Switch live with :colorscheme <name>; the airline
"                        status line theme follows automatically.
"   g:vimrc_truecolor    1 = use 24-bit colour (default). Set 0 for terminals
"                        that show garbled colours (old PuTTY, linux console).
"   g:vimrc_ultisnips    1 = load UltiSnips + vim-snippets (default). Set 0 to
"                        turn snippets off, e.g. once Copilot owns <Tab>.
let g:vimrc_colorscheme = get(g:, 'vimrc_colorscheme', 'gruvbox-material')
let g:vimrc_truecolor   = get(g:, 'vimrc_truecolor', 1)
let g:vimrc_ultisnips   = get(g:, 'vimrc_ultisnips', 1)


" Defacto standards
" -----------------

if (has("nvim"))
  " Neovim sets the following options by default since they have become defacto
  " standards. See `help nvim-defaults`.
else
  syntax on                       " use enable if want to keep custom colors
  filetype plugin indent on       " Enable file type detection.

  set autoindent    " Copy indent from current line when starting a new line
  set autoread      " Set to auto read when a file is changed from the outside
  set background=dark " Default background set to 'dark'
  set backspace=indent,eol,start  " more powerful backspacing
  "set backupdir    " Doesn't matter since backups are disabled after this
  set belloff=all   " Turn bell sound off
  set nocompatible  " Use Vim defaults instead of 100% vi compatibility
  set complete=.,w,b,u,t " Included files are excluded from default options
  " cscope is not available in Neovim, so guard on the feature, not on nvim.
  if has('cscope')
    set cscopeverbose " Neovim enables this by default; match it in Vim
  endif
  " set directory=     " Unnecessary since swapfile will be disabled after this
  set display=lastline " Show @@@ in the last line if it is truncated
  set encoding=utf8
  set fillchars=vert:│,fold:· " Separators for folds, windows, status
  set formatoptions=tcqj
  set hidden        " A buffer becomes hidden when it is abandoned
  set history=10000 " Maintain maximum history
  set hlsearch      " Highlight search results
  set incsearch     " Makes search act like search in modern browsers
  set laststatus=2  " Always show the status line
  set listchars="tab:> ,trail:-,nbsp:+"
  set nrformats=bin,hex
  set ruler         " show the cursor position all the time
  " Adds unix,slash to defaults and removes option from defaults
  set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize,terminal,unix,slash
  set shortmess=filnxtToOF
  set showcmd       " display incomplete commands
  set sidescroll=1
  set smarttab
  set nostartofline
  " TODO set switchbuf=uselast
  set tabpagemax=50
  set tags=./tags;,tags
  set ttimeoutlen=50
  set ttyfast
  " TODO undodir
  set viewoptions=folds,cursor,curdir,unix,slash
  " TODO viminfo
  set wildmenu		" display completion matches in a status line
  set wildoptions=tagfile
  if has('langmap') && exists('+langremap')
    " Prevent that the langmap option applies to characters that result from a
    " mapping.
    set nolangremap
  endif
endif


" Not-so-defacto standard general settings
" ----------------------------------------

" Turn backup off for both nvim and vim
set nobackup
set nowritebackup
set noswapfile
" Persist undo/redo history between sessions
if !has('nvim')
  let s:undodir = expand('~/.vim/undo')
  if !isdirectory(s:undodir) | call mkdir(s:undodir, 'p', 0700) | endif
  let &undodir = s:undodir . '//'    " // = full-path filenames, no collisions
endif
set undofile
" Make yank and delete operations copy to clipboard
if has('clipboard')
  if has('unnamedplus')
    set clipboard=unnamedplus
  else
    set clipboard=unnamed
  endif
else
  " No +clipboard in this Vim (e.g. Debian vim-nox): in Visual mode, \y pipes
  " the selection to an external clipboard tool, if one is installed.
  if !empty($WAYLAND_DISPLAY) && executable('wl-copy')
    xnoremap <silent> <leader>y :w !wl-copy<CR><CR>
  elseif executable('xclip')
    xnoremap <silent> <leader>y :w !xclip -selection clipboard<CR><CR>
  elseif executable('xsel')
    xnoremap <silent> <leader>y :w !xsel --clipboard --input<CR><CR>
  elseif executable('clip.exe')
    xnoremap <silent> <leader>y :w !clip.exe<CR><CR>
  elseif executable('pbcopy')
    xnoremap <silent> <leader>y :w !pbcopy<CR><CR>
  endif
endif
" Use Unix as the standard file type
set ffs=unix,dos
" Ignore case when searching and be smart about it
set ignorecase
set smartcase
" For regular expressions turn magic on
set magic


" Not-so-defacto standard UI settings
" -----------------------------------

" Show line numbers
set number
" Set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=7
" Change the cursor shape per mode for newer terminals (Vim only; Neovim and
" GUIs handle this themselves).
if !(has('nvim') || has("gui_running"))
  let &t_EI = "\e[1 q"   " Normal  : blinking block
  let &t_SI = "\e[5 q"   " Insert  : blinking bar
  let &t_SR = "\e[3 q"   " Replace : blinking underline
  let &t_ti = &t_ti . "\e[1 q"   " start in block cursor
  let &t_te = "\e[ q" . &t_te    " restore terminal's own cursor on exit
endif
" Height of the command bar
set cmdheight=2
" Show matching brackets when text indicator is over them
set showmatch
set mat=2
" Add a foldcolumn and enable folding
set foldcolumn=1
set foldmethod=indent
set foldlevel=40
" show tab and status lines always
set stal=2
" Use spaces instead of tabs
set expandtab
" Fixed width column which includes sign (error, warnings etc)
set signcolumn=yes
" Allow h,l keys to move up-down when at end or beginning of lines
set whichwrap+=h,l


" General settings (specific to user)
" -----------------------------------

" Ignore compiled files
set wildignore=*.o,*.a,*.so,*.pyc,*.swp,*.class
" Ignore version control metadata
if has('win32')
  set wildignore+=.git\*,.hg\*,.svn\*,node_modules\*
else
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/node_modules/*
endif
" Return to last edit position when opening files
augroup vimrc_lastpos
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit\|rebase' && expand('%:t') !~# '^\%(COMMIT_EDITMSG\|MERGE_MSG\|TAG_EDITMSG\|git-rebase-todo\)$' | exe "normal! g'\"" | endif
augroup END


" UI settings (specific to user)
" ------------------------------

" Show line numbers, relative line numbers
set rnu
" Set the special characters in a file
set listchars=tab:→\ ,nbsp:␣,trail:·,eol:↲,space:·
" 80, 100 column divider
let &colorcolumn="80,".join(range(100,999),",")
" Highlights beyond 100 look odd for wrapped lines, so for log type files with
" long lines, set only a single column
augroup vimrc_colorcolumn
  autocmd!
  autocmd BufRead,BufNewFile *.{txt,log,conf,md} setlocal cc=80
augroup END
" Visual mode pressing * searches for the current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>


" UI settings (specific to user and file type)
" --------------------------------------------
set shiftwidth=4 " TODO file specific tabs (eg. 2 for cpp but 4 for java)
set tabstop=4


" Not-so-defacto standard key mappings
" ------------------------------------

" See https://hea-www.harvard.edu/~fine/Tech/vi.html
" See https://code.visualstudio.com/shortcuts/keyboard-shortcuts-linux.pdf 

" Terminal Vim often does not decode Alt+key; teach it the ESC-prefix form.
if !has('nvim') && !has('gui_running')
  set ttimeout
  execute "set <M-j>=\ej"
  execute "set <M-k>=\ek"
  " Esc followed by j/k within 'ttimeoutlen' (laggy SSH) would arrive as <M-j>/<M-k>
  " and insert a stray character instead of leaving Insert mode. Treat as Esc + key.
  inoremap <M-j> <Esc>j
  inoremap <M-k> <Esc>k
endif
nnoremap <silent> <M-j> :m .+1<CR>==
nnoremap <silent> <M-k> :m .-2<CR>==
xnoremap <silent> <M-j> :m '>+1<CR>gv=gv
xnoremap <silent> <M-k> :m '<-2<CR>gv=gv
nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>
nnoremap <silent> <space> @=(foldlevel('.') ? 'za' : "\<Space>")<CR>

" vim(normal)     vscode              function
" ------------------------------------------------------------
" dd              Ctrl+X              Cut line (empty selection)
" yy              Ctrl+C              Copy line (empty selection)
" <M-j>           Alt+ ↓              Move line down
" <M-k>           Alt+ ↑              Move line up
"                 Ctrl+Shift+K        Delete line
" o               Ctrl+Enter          Insert line below
" O               Ctrl+Shift+Enter    Insert line above
" %               Ctrl+Shift+\        Jump to matching bracket
" >>              Ctrl+]              Indent/Outdent line
" >>              Ctrl+[              Indent/Outdent line
" 0 / Home        Home                Go to beginning of line
" ^                                   Go to beginning of line first char
" I                                   Go to beginning of line first char and switch to insert mode
" $ / End         End                 Go to end of line
" A                                   Go to end of line and switch to insert mode
" gg              Ctrl+ Home          Go to beginning of file
" G               Ctrl + End          Go to end of file
" <C-j>/<C-k>     Ctrl+ ↑ / ↓         Scroll line up/down
" PgUp / PgDn     Alt+ PgUp / PgDn    Scroll page up/down
" zc / zo         Ctrl+Shift+ [ / ]   Fold/unfold region
" za / <space>                        Toggle fold/unfold region
"                 Ctrl+K Ctrl+ [      Fold all subregions
" zO              Ctrl+K Ctrl+ ]      Unfold all subregions     *1
" zM              Ctrl+K Ctrl+0       Fold all regions
" zR              Ctrl+K Ctrl+J       Unfold all regions
"                 Ctrl+K Ctrl+C       Add line comment (comment whole line)
"                 Ctrl+K Ctrl+U       Remove line comment (uncomment whole line)
"                 Ctrl+/              Toggle line comment
"                 Ctrl+Shift+A        Toggle block comment
" :set wrap!<cr>  Alt+Z               Toggle word wrap (line wrap?)
" Ctrl-i, Ctrl-o                      Jump list cursor navigation (See :jumps)
" Ctrl-], Ctrl-T                      Tag stack cursor navigation (See :tags)
" gt, gT                              Next and previous tabs (See :tabs)
" .                                   Repeat last action

" *1 - For vim the cursor needs to be on the fold


" Key mappings for buffers and tabs (specific to users)
" -----------------------------------------------------

"""" Buffers

"  " Close the current buffer
"  map <leader>bd :Bclose<cr>:tabclose<cr>gT
"
"  " Close all the buffers
"  map <leader>ba :bufdo bd<cr>
"
"  map <leader>l :bnext<cr>
"  map <leader>h :bprevious<cr>

"""" Tabs

" Buffers to tabs
nnoremap <leader>tb :tab ball<cr>

" Useful mappings for managing tabs
nnoremap <leader>tn :tabnew<cr>
"map <leader>to :tabonly<cr>
"map <leader>tc :tabclose<cr>
"map <leader>tm :tabmove
"map <leader>t<leader> :tabnext

" Tab switching - Go to tab by number
nnoremap <leader>1 1gt
nnoremap <leader>2 2gt
nnoremap <leader>3 3gt
nnoremap <leader>4 4gt
nnoremap <leader>5 5gt
nnoremap <leader>6 6gt
nnoremap <leader>7 7gt
nnoremap <leader>8 8gt
nnoremap <leader>9 9gt
nnoremap <leader>0 :tabfirst<cr>

" Let 'tt' toggle between this and the last accessed tab
let g:lasttab = 1
augroup vimrc_lasttab
  autocmd!
  autocmd TabLeave * let g:lasttab = tabpagenr()
augroup END
nnoremap <Leader>tt :exe "tabn ".g:lasttab<CR>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
nnoremap <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Open same file in new tab
nnoremap <leader>ts :tab split<cr>


" Miscellaneous mappings for buffers and tabs (specific to users)
" ---------------------------------------------------------------

" Shortcut to enable showing special characters (see listchars)
nnoremap <leader><Tab> :set list!<cr>

" Switch foldmethods with the leader key
nnoremap <leader>zi :set foldmethod=indent<cr>
nnoremap <leader>zs :set foldmethod=syntax<cr>
nnoremap <leader>zm :set foldmethod=manual<cr>

" Disable highlight when <leader><cr> is pressed
nnoremap <silent> <leader><cr> :noh<cr>

" Shows jumps
nnoremap <leader>j :jumps<cr>

" Switch CWD to the directory of the open buffer
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" Pressing \ss will toggle and untoggle spell checking
nnoremap <leader>ss :setlocal spell!<cr>

" Spellcheck shortcuts using <leader>
nnoremap <leader>sn ]s
nnoremap <leader>sp [s
nnoremap <leader>sa zg
nnoremap <leader>s? z=

" Remove the Windows ^M - when the encodings gets messed up
nnoremap <silent> <Leader>m :call <SID>StripCR()<CR>

" Quickly open a buffer for scribble
nnoremap <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
nnoremap <leader>x :e ~/buffer.md<cr>


" Helper functions
" ----------------

" Visual mode: use the selected text as the search pattern (see the * mapping)
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Remove DOS ^M characters, keeping cursor/scroll position and your marks
function! s:StripCR() abort
    let l:view = winsaveview()
    keeppatterns %s/\r//ge
    call winrestview(l:view)
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins - Package manager
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Installation
" curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" EditorConfig is built in to Neovim 0.9+ and bundled with Vim 9.0.1776+.
" Older versions get the plugin instead.
let s:builtin_editorconfig = has('nvim') ? has('nvim-0.9') : has('patch-9.0.1776')

" vim-polyglot would otherwise claim *.s / *.S as R and leave *.asm undetected.
" Disabling its R pack lets Vim's own runtime detect assembly.
let g:polyglot_disabled = ['r-lang']

call plug#begin()

" ### lang-support
if !has('nvim')
  Plug 'sheerun/vim-polyglot'
endif

" ### editorconfig (only where it is not built in)
if !s:builtin_editorconfig
  Plug 'editorconfig/editorconfig-vim'
endif

" ### colorschemes
" Many are installed on purpose: different people on the team prefer different
" ones (see g:vimrc_colorscheme at the top). Remove the ones nobody uses.
Plug 'altercation/vim-colors-solarized'  " most popular vim theme (adopted from terminal theme solarized )
Plug 'nanotech/jellybeans.vim'           " popular vim colorscheme (based on classic vim)
Plug 'jnurmine/zenburn'                  " popular vim colorscheme (low contrast)
" ### colorschemes - other editors
Plug 'tomasr/molokai'                    " port of monokai theme for TextMate
Plug 'joshdick/onedark.vim'              " port of default atom theme (similar to sublime3)
Plug 'tomasiser/vim-code-dark'           " port of vscode dark theme
" ### maintained colorschemes with matching airline themes
Plug 'sainnhe/sonokai'                   " monokai-like (sublime style), several variants
Plug 'sainnhe/gruvbox-material'          " softer, maintained gruvbox (solarized with blue filter)

" ### interface
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'    " airline themes for solarized, zenburn, molokai, ...
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'LunarWatcher/auto-pairs'

" ### completion
" Snippets are optional: `let g:vimrc_ultisnips = 0` (see top of file) skips both.
if g:vimrc_ultisnips
  Plug 'sirver/ultisnips'                " Snippet engine (needs Python 3 support)
  Plug 'honza/vim-snippets'              " Snippet repo
endif
" TODO: copilot for completions

" ### syntax-check
Plug 'dense-analysis/ale'

call plug#end()

" Vim 9.0.1776+ ships EditorConfig as an optional package; Neovim 0.9+ has it
" built in and needs nothing. (.editorconfig files override the global
" expandtab/shiftwidth/tabstop above, per project.)
if !has('nvim') && s:builtin_editorconfig
  silent! packadd editorconfig
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins - Static
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"   curl -LSso ~/.vim/plugin/pathogen.vim http://cscope.sourceforge.net/cscope_maps.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins - Colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use 24-bit (true-color) mode in Vim/Neovim, including inside tmux/screen.
" Opt out with `let g:vimrc_truecolor = 0` on terminals that do not support it.
" tmux itself must advertise it too (tmux >= 3.2):
"     set -as terminal-features ',*:RGB'     (older tmux: set -ga terminal-overrides ',*:Tc')
if g:vimrc_truecolor && has("termguicolors")
  if !has('nvim') && &term =~# '^\%(screen\|tmux\)'
    " Vim does not know the 24-bit escape codes under screen/tmux; set them.
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
  set termguicolors
endif

" Set users choice of colorscheme
set t_Co=256
set t_ut=
execute 'colorscheme ' . g:vimrc_colorscheme
" Airline picks the theme that matches the colorscheme name by itself (and
" follows later :colorscheme changes), so g:airline_theme is deliberately NOT
" set here. Set it in your own vimrc if you want a fixed airline theme.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins - Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1

"" nerdtree
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeFind<CR>

"" tagbar
nnoremap <F8> :TagbarToggle<CR>

"" fzf (replaces ctrlp). Needs the fzf binary (installed by :PlugInstall);
"" :Rg needs ripgrep. fzf ignores 'wildignore'; for .gitignore-aware file lists
"" put this in your shell rc:
""     export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git"'
nnoremap <C-p> :Files<CR>
nnoremap <leader>b :Buffers<CR>
if executable('rg')
  nnoremap <leader>/ :Rg<space>
endif

"" auto-pairs
let g:AutoPairsMapBS = 1                 " Backspace deletes an empty pair
let g:AutoPairsCompleteOnlyOnSpace = 1   " no auto-close right before a word
let g:AutoPairsMapSpace = 0              " no padding like ( x )

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins - Completion / Snippets
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-snippets with ultisnips engine. Type e.g. `for<Tab>` to expand a loop,
" <Tab> / <S-Tab> to jump between the placeholders.
" UltiSnips needs Python 3 support (:echo has('python3') must print 1; Neovim
" needs the `pynvim` package). Without it the plugin silently does nothing.
if g:vimrc_ultisnips
  let g:UltiSnipsExpandTrigger       = '<Tab>'
  let g:UltiSnipsJumpForwardTrigger  = '<Tab>'
  let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'
endif
" ---- When GitHub Copilot (github/copilot.vim) is installed ----
" Copilot also claims <Tab> to accept a suggestion, so the two will fight.
" Pick ONE of these:
"  (a) Keep both: move UltiSnips off <Tab> by changing the three triggers
"      above to e.g.  '<C-j>'  (expand),  '<C-j>'  (forward),  '<C-k>'  (backward)
"  (b) Turn snippets off completely: `let g:vimrc_ultisnips = 0` before
"      sourcing this file (top of file); UltiSnips and vim-snippets are then
"      neither loaded nor configured.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins - Syntax / Linter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Keep ALE quiet: sign-column markers + message in the command line on the cursor line
let g:ale_virtualtext_cursor = 'disabled'   " no inline end-of-line text (default is 'all')
let g:ale_echo_cursor        = 1            " message in the command line when cursor is on the line
let g:ale_lint_on_insert_leave = 0          " don't lint every time you press Esc
let g:ale_lint_on_enter      = 1            " lint when a file is opened
let g:ale_lint_on_save       = 1            " lint when you :w
let g:ale_lint_on_text_changed = 'never'     " lint on save / leaving insert only

" ALE (async lint engine; replaces syntastic).
"
" Choice of linters and best installation sources:
" C       cc, cppcheck, gcc,        System wide install (eg. via apt)
" C++     cc, cppcheck, clangtidy   System wide install (eg. via apt)
" CMake   cmake_lint                System wide install (eg. for apt, cmake-format installs pkg)
" Bazel   buildifier                System wide manual install from GitHub src
" asm     (none)                    Removed: gcc linter gives false positives on ARM/NASM
" Shell   shell, shellcheck         System wide install (eg. via apt)
" Java    javac                     System wide install (eg. via apt)
" Rust    cargo (+ clippy)          System wide install (via rustup)
" Python  ruff, mypy                mypy system wide for random files. Override ruff, mypy in venv
" SQL     sqlfluff                  System wide for Cpp, Java, Rust, etc. Override in venv for Py.
"         WARN: vim must be launched from venv for sqlfluff to use venv version
" JS/TS   eslint                    npm env
" HTML    htmlhint                  npm env (Can use tidy from apt pkg, but unnecessary for me)
" CSS     stylelint                 npm	env
let g:ale_linters_explicit = 1          " ONLY the linters listed below run (no surprise
                                        " language servers such as tsserver/gopls/clangd)
let g:ale_linters = {
\   'c':          ['cc', 'cppcheck'],
\   'cpp':        ['cc', 'cppcheck', 'clangtidy'],
\   'python':     ['ruff', 'mypy'],
\   'sh':         ['shell', 'shellcheck'],
\   'java':       ['javac'],
\   'javascript': ['eslint'],
\   'typescript': ['eslint'],
\   'html':       ['htmlhint'],
\   'css':        ['stylelint'],
\   'rust':       ['cargo'],
\   'sql':        ['sqlfluff'],
\   'cmake':      ['cmake_lint'],
\   'bzl':        ['buildifier'],
\}
let g:ale_rust_cargo_use_clippy = 1     " cargo check -> clippy
let g:ale_c_parse_compile_commands = 1  " use compile_commands.json if present

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins - Filetype
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Delete trailing white space on save. Enabled for python and cxx.
function! s:TrimTrailingWS() abort
  let l:view = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:view)
endfunction
augroup trim_ws
  autocmd!
  autocmd BufWritePre *.py,*.c,*.h,*.cc,*.cpp,*.hpp call s:TrimTrailingWS()
augroup END
