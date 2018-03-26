
set nocompatible
set shell=/bin/zsh

if exists('g:loaded_sensible') || &compatible
  finish
else
  let g:loaded_sensible = 1
endif

set encoding=utf-8
set fileencoding=utf-8

let g:onedark_termcolors=16
let g:onedark_terminal_italics=0
colorscheme onedark
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Iosevka\ Term\ 15
  endif
endif

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk
map <DOWN> j
map <UP> k
map <RIGHT> l
map <LEFT> h

if has('autocmd')
  filetype plugin indent on
endif

if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" Use :help 'option' to see the documentation for the given option.

set autoindent
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
set complete-=i
set smarttab

set nrformats-=octal

set ttimeout
set ttimeoutlen=100

set ignorecase
set smartcase
set incsearch
set hlsearch
" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

set laststatus=2
set ruler
set showcmd
set lazyredraw

set wildmenu
set wildignore=*.o,*~,*.pyc,*.so,*.class,.DS_Store
set wildmode=longest:full,full

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

if &encoding ==# 'latin1' && has('gui_running')
  set encoding=utf-8
endif

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

set autoread
set fileformats+=mac

if &history < 1000
  set history=1000
endif
if &tabpagemax < 50
  set tabpagemax=50
endif
if !empty(&viminfo)
  set viminfo^=!
endif
set sessionoptions-=options

" Allow color schemes to do bright colors without forcing bold.
if &t_Co == 8 && $TERM !~# '^linux'
  set t_Co=16
endif
""""""""""""""
" tmux fixes "
""""""""""""""
" Handle tmux $TERM quirks in vim
if $TERM =~ '^screen-256color'
    map <Esc>OH <Home>
    map! <Esc>OH <Home>
    map <Esc>OF <End>
    map! <Esc>OF <End>
endif

" Load matchit.vim, but only if the user hasn't installed a newer version.
if !exists('g:loaded_matchit') && findfile('plugin/matchit.vim', &rtp) ==# ''
  runtime! macros/matchit.vim
endif

inoremap <C-U> <C-G>u<C-U>

" change leader key from '\' to ';'
let mapleader=';'

" edit/reload vimrc
nmap <silent> <leader>ve :e $MYVIMRC<CR>
nmap <silent> <leader>vs :so $MYVIMRC<CR>

" :W sudo saves the file (doesn't work on cygwin)
if !has("win32")
    command! W w !sudo tee % > /dev/null
endif

" hide gvim toolbar, scrollbars
set go-=T
set go-=r
set go-=l
set go-=b

" Set lines to the cursor - when moving vertically using j/k
set so=6

" Height of the command bar
set cmdheight=1

" A buffer becomes hidden when it is abandoned
set hid

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

" no startup message
set shortmess+=I

" Folding
set foldmethod=indent
" left margin
set foldcolumn=0
" don't auto-fold
set foldlevel=999

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
set expandtab

" 1 tab == 4 spaces
set tabstop=2
set shiftwidth=2
"set noexpandtab
" auto indent
set ai
" smart indent
set si
" wrap lines
set wrap

" Visual mode pressing * searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" center window after some commands
nnoremap n nzz
nnoremap N Nzz

" Window mappings
map <leader>w <C-W>
map <leader>we :split<SPACE>
map <leader>wc <C-W>n
map <leader>wd <C-W>q
map <leader>wt <C-W>T
map <leader>wn <C-W>w
map <leader>wp <C-W>W

" Tab mappings
map <leader>tc :tabnew<CR>
map <leader>to :tabonly<CR>
map <leader>td :tabclose<CR>
map <leader>tm :tabmove<SPACE>
map <leader>tn :tabnext<CR>
map <leader>tp :tabprevious<CR>
map <leader>te :tabedit<SPACE>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab=1
nmap <leader>tl :exe "tabn ".g:lasttab<CR>
autocmd TabLeave * let g:lasttab=tabpagenr()

" Buffer operations
source ~/.vim/BufOnly.vim
map <silent> <leader>bo :BufOnly<CR>
map <leader>bn :bn<CR>
map <leader>bp :bp<CR>
map <leader>bd :Bclose<CR>
map <leader>ba :1,1000 bd!<CR>

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum=bufnr("%")
    let l:alternateBufNum=bufnr("#")
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

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<CR>:pwd<CR>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()
autocmd BufWrite *.vala :call DeleteTrailingWS()
autocmd BufWrite *.js :call DeleteTrailingWS()
autocmd BufWrite *.php :call DeleteTrailingWS()

" helper function
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" visual mode search
function! VisualSelection(direction, extra_filter) range
    let l:saved_reg=@"
    execute "normal! vgvy"

    let l:pattern=escape(@", '\\/.*$^~[]')
    let l:pattern=substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("Ack \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/=l:pattern
    let @"=l:saved_reg
endfunction

" Toggle paste mode on and off
map <silent> <leader>p :setlocal paste!<CR>

" activate closetag plugin for xml types
" autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
" autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim

" activate spell check for git commits, and other types
autocmd FileType gitcommit set spell spelllang=en_us
autocmd FileType markdown set spell spelllang=en_us

" supertab/autocomplete options
set omnifunc=syntaxcomplete#Complete
set completeopt+=longest
let g:SuperTabDefaultCompletionType="context"

" line numbers for specific filetypes
autocmd FileType python setl number
autocmd FileType vala setl number
set numberwidth=1

" git shortcuts
map <leader>gw :Gwrite<CR>
map <leader>gc :Gcommit<CR>
map <leader>gp :Gpush<CR>
map <leader>gs :Gstatus<CR>
map <leader>gd :Gdiff<CR>
map <leader>gr :Grevert<CR>
set diffopt=filler,vertical
command! Grevert :Git checkout -- %

" activate tagbar (requires ctags)
let g:tagbar_usearrows=1
let g:tagbar_autofocus=1
let g:tagbar_zoomwidth=0
let g:tagbar_compact=1
let g:tagbar_autoclose = 1
nnoremap <leader>l :TagbarToggle<CR>

" nerdtree
map <leader>nl :NERDTreeToggle<CR>
map <leader>ne :NERDTree<SPACE>
let NERDTreeIgnore=['\.pyc$[[file]]','\.so$[[file]]','\.class$[[file]]']
let NERDTreeQuitOnOpen=1

" open syntastic error window on errors
let g:syntastic_javascript_checkers=['jscs', 'jshint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1

" airline status theme
set showtabline=1

if has("gui_win32")
    let g:gitgutter_enabled = 0
    source $VIMRUNTIME/mswin.vim
    behave mswin
endif

" disable syntastic check (compile) on save
let g:syntastic_vala_check_disabled = 1
" vala
" Disable valadoc syntax highlight
"let vala_ignore_valadoc = 1
let g:syntastic_vala_vapi_dirs = "/usr/share/vala-0.32/vapi"
" Enable comment strings
let vala_comment_strings = 1

" Highlight space errors
let vala_space_errors = 1
" Disable trailing space errors
"let vala_no_trail_space_error = 1
" Disable space-tab-space errors
let vala_no_tab_space_error = 1

" Minimum lines used for comment syncing (default 50)
"let vala_minlines = 120

