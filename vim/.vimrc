
set encoding=utf-8
set fileencoding=utf-8

set background=dark

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk
map <DOWN> j
map <UP> k
map <RIGHT> l
map <LEFT> h

" turn on syntax completion
set omnifunc=syntaxcomplete#Complete

set whichwrap+=<,>,h,l
" no timeout (onscreen keyboard compat)
set notimeout
set ttimeout

set ignorecase
set smartcase
set hlsearch

set showcmd
set lazyredraw

" ignore files in menu
set wildignore=*.o,*~,*.pyc,*.so,*.class,.DS_Store
set wildmode=longest:full,full

set fileformats+=mac

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

" change leader key from '\' to ';'
let mapleader=';'

" edit/reload vimrc
nmap <silent> <leader>ve :e $MYVIMRC<CR>
nmap <silent> <leader>vs :so $MYVIMRC<CR>

" :w!! sudo saves the file (doesn't work on cygwin)
if !has("win32")
    cmap w!! w !sudo tee % > /dev/null
endif

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

" 1 tab == 2 spaces
set tabstop=2
set shiftwidth=2
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

" fzf commands
command! FZFtabedit call fzf#run({'sink': 'tabedit', 'options': '--multi', 'down': '40%'})
command! FZFedit call fzf#run({'sink': 'edit', 'options': '--multi', 'down': '40%'})
map <leader>fte :FZFtabedit<CR>
map <leader>fe :FZFedit<CR>

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

" Delete trailing white space on save
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

" activate spell check for git commits, and other types
autocmd FileType gitcommit set spell spelllang=en_us
autocmd FileType markdown set spell spelllang=en_us
" line numbers for specific filetypes
autocmd FileType python setl number
autocmd FileType vala setl number
autocmd FileType javascript setl number
autocmd FileType coco setl number
autocmd FileType gdscript3 setl number
autocmd FileType gdscript3 setl noexpandtab
set numberwidth=1
set cursorline

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
let g:tagbar_autoclose=1
nnoremap <leader>l :TagbarToggle<CR>

" nerdtree
map <leader>nl :NERDTreeToggle<CR>
map <leader>ne :NERDTree<SPACE>
let NERDTreeIgnore=['\.pyc$[[file]]','\.so$[[file]]','\.class$[[file]]']
let NERDTreeQuitOnOpen=1
set showtabline=1
set statusline=%<\ %f\ %m%r%=%y\ %-2.(%l,%c%V%)\ 

" tmux title
if exists('$TMUX')
  autocmd BufEnter * call system("tmux rename-window " . expand("%:t"))
  autocmd VimLeavePre * call system("tmux setw automatic-rename")
  autocmd BufEnter * let &titlestring = ' ' . expand("%:t")
  set title
endif

set completeopt=menuone,noinsert
set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " If Vim beeps during completion
let g:mucomplete#enable_auto_at_startup=1
let g:mucomplete#completion_delay = 500

" plug
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'w0rp/ale'
Plug 'lifepillar/vim-mucomplete'
Plug 'LnL7/vim-nix'
Plug 'joegesualdo/jsdoc.vim'
call plug#end()
colorscheme starlight
hi Normal guibg=#212121 ctermbg=NONE
