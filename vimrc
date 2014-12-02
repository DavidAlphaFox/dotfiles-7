
execute pathogen#infect()

" change leader key from '\' to ';'
let mapleader=';'

" edit/reload vimrc
nmap <silent> <leader>ve :e $MYVIMRC<CR>
nmap <silent> <leader>vs :so $MYVIMRC<CR>

" :W sudo saves the file
command! W w !sudo tee % > /dev/null

" Set lines to the cursor - when moving vertically using j/k
set so=6

" wait forever for key combo completion
set notimeout

" set language to en
let $LANG='en'
set langmenu=en

" Ignore compiled files
set wildignore=*.o,*~,*.pyc,*.so,*.class
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif
" wild menu tab completion mode
set wildmode=longest:full,full

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
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

" no startup message
set shortmess+=I

" Folding
set foldmethod=indent

" Add a bit extra margin to the left
set foldcolumn=0

" solarized colors
syntax enable
set background=dark
let g:solarized_termtrans=1
colorscheme solarized

set t_Co=256

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

" Use spaces instead of tabs
set expandtab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

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

" Treat long lines as break lines (useful when moving around in them)
map j gj
map k gk
map <DOWN> j
map <UP> k
map <RIGHT> l
map <LEFT> h

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
map <silent> <leader>pp :setlocal paste!<CR>

" activate closetag plugin for xml types
autocmd FileType html,htmldjango,jinjahtml,eruby,mako let b:closetag_html_style=1
autocmd FileType html,xhtml,xml,htmldjango,jinjahtml,eruby,mako source ~/.vim/bundle/closetag/plugin/closetag.vim

" supertab/autocomplete options
set omnifunc=syntaxcomplete#Complete
set completeopt+=longest
let g:SuperTabDefaultCompletionType="context"

" line numbers for specific filetypes
autocmd FileType python setl number
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
let g:syntastic_auto_loc_list=1

" airline status theme
set showtabline=1
let g:airline_theme='bubblegum'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#show_buffers=0
let g:airline#extensions#tabline#tab_min_count=2
let g:airline#extensions#tabline#left_sep=''
let g:airline#extensions#tabline#left_alt_sep=''
let g:airline_left_sep='►'
let g:airline_right_sep='◄'
let g:airline#extensions#tabline#show_close_button=0
let g:airline#extensions#tabline#show_tab_nr=0
let g:airline_section_b='%<%f%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
let g:airline_section_c='%{getcwd()}'
let g:airline_section_y='%{airline#util#wrap(airline#extensions#hunks#get_hunks(),0)}%{airline#util#wrap(airline#extensions#branch#get_head(),0)}'

