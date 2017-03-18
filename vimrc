"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This file is adapted from https://github.com/amix/vimrc
"
" References:
"  Moving in vim: http://vim.wikia.com/wiki/All_the_right_moves
"  Tabs in vim: http://vim.wikia.com/wiki/Using_tab_pages
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Sets how many lines of history VIM has to remember - <command>
set history=500

" Set to auto read when a file is changed from the outside - <NA>
set autoread

" Turn backup off, since most stuff is in SVN, git et.c anyway - <NA>
set nobackup
set nowb
set noswapfile

" Turn on the WiLd menu - <command>
set wildmenu


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Common Leader shortcuts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
"let mapleader = "\"
"let g:mapleader = "\"

" Fast saving - <command>
"nmap <leader>w :w!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Show line numbers - <normal,insert,visual>
set number

" set the special characters in a file
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
" shortcut to enable showing special characters
map <leader><Tab> :set list!<cr>

" 80, 120 column divider
let &colorcolumn="80,".join(range(120,999),",")

" Set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=7

" Avoid garbled characters in Chinese language windows OS
let $LANG='en' 
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Make yank and delete operations copy to clipboard
set clipboard=unnamedplus

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases 
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch 

" Don't redraw while executing macros (good performance config)
set lazyredraw 

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif

" Add a bit extra margin to the left
set foldcolumn=1

" Enable folding
set foldmethod=syntax
set foldlevel=40

" Enable folding with the spacebar
nnoremap <space> za

" Switch foldmethods with the leader key
map <leader>zi :set foldmethod=indent<cr>
map <leader>zs :set foldmethod=syntax<cr>
map <leader>zm :set foldmethod=manual<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax enable 

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

try
    colorscheme desert
catch
endtry

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Set font according to system
if has("mac") || has("macunix")
    set gfn=Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
elseif has("win16") || has("win32")
    set gfn=Hack:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("gui_gtk2")
    set gfn=Source\ Code\ Pro\ 11,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("linux")
    set gfn=Hack\ 11,Source\ Code\ Pro\ 11,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("unix")
    set gfn=Monospace\ 11
endif

" Disable scrollbars (real hackers don't use scrollbars for navigation!)
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" Linebreak on 500 characters
set lbr
set tw=500

set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines


""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
"map <space> /
"map <c-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

"""" Windows

" Smart way to move between windows
"map <C-j> <C-W>j
"map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Page up , page down
nnoremap <C-k> <C-u>
nnoremap <C-j> <C-d>

"""" Buffers

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

"""" Tabs

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
nmap <Leader>tt :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Open same file in new tab
map <leader>ts :tab split<cr>

"""" Misc

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
"map 0 ^ " Rishin - Don't want same behaviour of 0 and ^

" Move a line of text using ALT+[jk] or Command+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Visual/Normal mode copy paste
" Note pasting with Ctrl-V in normal mode pastes before cursor as opposed to
" after cursore with p
vnoremap <C-c> "+y
vnoremap <C-v> "+gP
" bad idea to have c-v in normal mode as visual block is mapped to the key
"noremap <C-v> "+gP

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing jumps
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Shows jumps
map <leader>j :jumps<cr>

" Jumping back, forward
" Ctrl-i, Ctrl-o are default mapings


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Ag searching and cope displaying
"    requires ag.vim - it's much better than vimgrep/grep
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you Ag after the selected text
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open Ag and put the cursor in the right position
map <leader>g :Ag 

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with Ag, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" Make VIM remember position in file after reopen
" if has("autocmd")
"   au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins - Package manager - Pathogen
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Installation 
"   mkdir -p ~/.vim/autoload ~/.vim/bundle ~/.vim/plugin && \
"   curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

" Enable pathogen
execute pathogen#infect()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins - Static
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"   curl -LSso ~/.vim/plugin/pathogen.vim http://cscope.sourceforge.net/cscope_maps.vim


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins - Filetype
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable filetype plugins
filetype on
filetype plugin on
filetype indent on

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" Install the following (assumes pathogen plugin is on)
"    git clone https://github.com/fatih/vim-go.git ~/.vim/bundle/vim-lang-go
"    git clone https://github.com/groenewege/vim-less ~/.vim/bundle/vim-lang-less
"    git clone https://github.com/kchmck/vim-coffee-script.git ~/.vim/bundle/vim-lang-coffeescript/
"    git clone https://github.com/evanmiller/nginx-vim-syntax.git ~/.vim/bundle/vim-lang-nginx
"    git clone https://github.com/pangloss/vim-javascript.git ~/.vim/bundle/vim-lang-javascript


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins - Colors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Install the following (assumes pathogen plugin is on)
"   git clone https://github.com/w0ng/vim-hybrid ~/.vim/bundle/vim-colors-hybrid

" enable a color scheme
set background=dark
colorscheme hybrid
let g:hybrid_reduced_contrast = 1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins - Completion / Snippets
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins - Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"   cd ~/.vim/bundle; wget http://cscope.sourceforge.net/cscope_maps.vim
"   git clone https://github.com/itchyny/lightline.vim.git ~/.vim/bundle/lightline
"   git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
"   git clone https://github.com/tmhedberg/simpylfold  ~/.vim/bundle/simpylfold

map <C-n> :NERDTreeToggle<CR>
