"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This file is adapted from github.com/amix/vimrc
"
" References
"  Moving in vim - vim.wikia.com/wiki/All_the_right_moves
"  Tabs in vim - vim.wikia.com/wiki/Using_tab_pages
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
  " TODO cscopeverbose
  " set directory=     " Unnecessary since swapfile will be disabled after this
  set display=lastline " Show @@@ in the last line if it is truncated
  set encoding=utf8
  set fillchars=vert:│,fold:· " Seperators for folds, windows, status
  set formatoptions=tcqj
  set nofsync
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
" Make yank and delete operations copy to clipboard
set clipboard=unnamed
" Use Unix as the standard file type
set ffs=unix,dos,mac
" Ignore case when searching and be smart about it
set ignorecase
set smartcase
" For regular expressions turn magic on
set magic
" Don't redraw while executing macros (good performance config)
set lazyredraw


" Not-so-defacto standard UI settings
" -----------------------------------

" Show line numbers
set number
" Set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=7
" Change the cursore in in insert mode for newer terminals
if has('nvim') || has("gui_running")
else
    if has("autocmd")
      au VimEnter,InsertLeave * silent execute '!echo -ne "\e[1 q"' | redraw!
      au InsertEnter,InsertChange *
        \ if v:insertmode == 'i' |
        \   silent execute '!echo -ne "\e[5 q"' | redraw! |
        \ elseif v:insertmode == 'r' |
        \   silent execute '!echo -ne "\e[3 q"' | redraw! |
        \ endif
      au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
    endif
endif
" Height of the command bar
set cmdheight=2
" Show matching brackets when text indicator is over them
set showmatch
set mat=2
" Add a foldcolumn and enable folding
set foldcolumn=1
set foldmethod=syntax
set foldlevel=40
" show tab and status lines always
set stal=2
" Use spaces instead of tabs
set expandtab
" Fixed width column which includes sign (error, warnings etc)
set signcolumn=yes
" Allow h,l keys to move up-down when at end or begining of lines
set whichwrap+=h,l


" General settings (specific to user)
" -----------------------------------

" Ignore compiled files
set wildignore=*.o,*.a,*.so,*.pyc,*.swp,*.class
" Ignore version control metdata
if has("win16") || has("win32")
  set wildignore+=.git\*,.hg\*,.svn\*,node_modules\*
else
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/node_modules/*
endif
" Return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


" UI settings (specific to user)
" ------------------------------

" Show line numbers, relaive line numbers
set rnu
" Set the special characters in a file
set listchars=tab:→\ ,nbsp:␣,trail:·,eol:↲,space:·
" 80, 100 column divider
let &colorcolumn="80,".join(range(100,999),",")
" Highlights beyond 100 look odd for wrapped lines, so for log type files with
" long lines, set only a single column
autocmd BufRead,BufNewFile *.{txt,log,conf,md} setlocal cc=80
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

nnoremap <M-j> ddp
nnoremap <M-k> ddkP
nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>
nnoremap <space> za


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
" $ / End         End                 Go to end of line
" gg              Ctrl+ Home          Go to beginning of file
" G               Ctrl + End          Go to end of file
" <C-j>/<C-k>     Ctrl+ ↑ / ↓         Scroll line up/down
"                 Alt+ PgUp / PgDn    Scroll page up/down
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
" .                                   Repeat last action

" *1 - For vim the cursor needs to be on the fold




" Page up , page down
"nnoremap <C-k> <C-u>
"nnoremap <C-j> <C-d>

" Move to begining or end of line
"map <C-h> ^
"map <C-l> $

" Move a line of text using ALT+[jk] or Command+[jk] on mac
"""""" nmap <M-j> mz:m+<cr>`z
"""""" nmap <M-k> mz:m-2<cr>`z
"""""" vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
"""""" vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z
"""""" if has("mac") || has("macunix")
""""""   nmap <D-j> <M-j>
""""""   nmap <D-k> <M-k>
""""""   vmap <D-j> <M-j>
""""""   vmap <D-k> <M-k>
"""""" endif

" Jumping back, forward
" Ctrl-i, Ctrl-o are default mapings

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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


" shortcut to enable showing special characters (see listchars)
map <leader><Tab> :set list!<cr>
" Switch foldmethods with the leader key
map <leader>zi :set foldmethod=indent<cr>
map <leader>zs :set foldmethod=syntax<cr>
map <leader>zm :set foldmethod=manual<cr>


" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>


" Shows jumps
map <leader>j :jumps<cr>




" Buffers to tabs
map <leader>tb :tab ball<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
"map <leader>to :tabonly<cr>
"map <leader>tc :tabclose<cr>
"map <leader>tm :tabmove
"map <leader>t<leader> :tabnext

" Tab switching - Go to tab by number
" gt - Next tab
" gT - Previous tab
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tabfirst<cr>

" Let 'tt' toggle between this and the last accessed tab
let g:lasttab = 1
au TabLeave * let g:lasttab = tabpagenr()
nmap <Leader>tt :exe "tabn ".g:lasttab<CR>

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Open same file in new tab
map <leader>ts :tab split<cr>

"""" Misc

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>



" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Spellcheck shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=



" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ag '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
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

call plug#begin()
" ### lang-support
"if has('nvim')
"    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"else
Plug 'sheerun/vim-polyglot'
"endif

" ### colorschemes
Plug 'altercation/vim-colors-solarized'  " most popular vim theme (adopted from terminal theme solaris )
Plug 'tomasr/molokai'                    " port of monokai theme for TextMate
Plug 'rakr/vim-one'                      " port of default atom theme
Plug 'tomasiser/vim-code-dark'           " port of dark+ them from vscode
Plug 'w0ng/vim-hybrid'                   " personal choice
Plug 'nanotech/jellybeans.vim'           " popular vim colorscheme

" ### interface
Plug 'vim-airline/vim-airline'
if has('nvim')
  Plug 'kyazdani42/nvim-web-devicons'     " Coloured icons)
  " Plug 'ryanoasis/vim-devicons' Icons without colours
  Plug 'akinsho/nvim-bufferline.lua'
endif
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf'                      " Plug 'Mofiqul/vscode.nvim' replaced by fzf
Plug 'jiangmiao/auto-pairs'

" ### completion
Plug 'honza/vim-snippets'
Plug 'sirver/ultisnips'
" deoplete related
if has('nvim')
  Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" ### syntax-check
Plug 'w0rp/ale'

"Plug 'OmniSharp/omnisharp-vim'

call plug#end()



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins - Static
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"   curl -LSso ~/.vim/plugin/pathogen.vim http://cscope.sourceforge.net/cscope_maps.vim


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins - Colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Set users choice of colorscheme
let g:jellybeans_use_lowcolor_black = 1
colorscheme jellybeans


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins - Interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1

"" nerdtree
map <C-n> :NERDTreeToggle<CR>
"map <C-t> :NERDTreeFind<CR>

"" tagbar
nmap <F8> :TagbarToggle<CR>

"" fzf
nmap <C-p> :FZF<CR>

"" auto-pairs
let g:AutoPairsMultilineClose = 0 " doesn't delete next line brace when deleting current one

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins - Completion / Snippets
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" vim-snippets with ultisnips engine
" remapped from tab to avoid conflict with tab completion
let g:UltiSnipsExpandTrigger="<C-space>"
let g:UltiSnipsJumpForwardTrigger="<C-space>"
let g:UltiSnipsJumpBackwardTrigger="<S-space>"


"" LanguageClient-neovim (deoplete source for lsp servers)
if has('nvim')
  let g:LanguageClient_serverCommands = {
        \ 'cpp': [ 'clangd' ],
        \ }

  let g:LanguageClient_useVirtualText='No'
  let g:LanguageClient_diagnosticsEnable = 0 " Diagnostics are taken from ALE

  " note that if you are using Plug mapping you should not use `noremap` mappings.
  nmap <F5> <Plug>(lcn-menu)
  " Or map each action separately
  nmap <silent>K <Plug>(lcn-hover)
  nmap <silent> gd <Plug>(lcn-definition)
  nmap <silent> <F2> <Plug>(lcn-rename)
endif

"" Deoplete
let g:deoplete#enable_at_startup = 1
" tab completion with deoplete
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" : "\<TAB>"

set completeopt-=preview " vim ins-completeion subsystem option to disable scratch buffers

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins - Syntax / Linter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ALE
" disable lint on text change
let g:ale_lint_on_text_changed = 0
" Limit C/CPP linters
let g:ale_linters = {
\   'cpp': ['cc'],
\}
let g:ale_c_parse_compile_commands = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins - Filetype
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Delete trailing white space on save. Enabled for python and cxx.
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.cpp :call DeleteTrailingWS()
autocmd BufWrite *.hpp :call DeleteTrailingWS()
autocmd BufWrite *.c :call DeleteTrailingWS()
autocmd BufWrite *.h :call DeleteTrailingWS()

