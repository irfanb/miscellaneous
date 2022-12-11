ser csre
set nocompatible
set diffopt+=iwhite
set fileformats=unix,dos
behave xterm
set ai sw=4 aw
set wm=8
set ws
set ic
set ts=4
set cindent
set smartindent
set dir=~/tmp
set expandtab
set cmdheight=2
set errorfile=/tmp/errors.vim
set makeprg=make
set makeef=~/tmp/errors
set errorformat=%f\:%l\:%c\:\ %m
set tags=./tags,tags,~/LH/tags
set ruler
set noequalalways
set incsearch
set showmatch
set path=.,/usr/include
set dictionary=/home/irfan/.sqsh_words,/usr/share/lib/dict/words
set backspace=2
set viminfo='50,\"1000,%,n$HOME/viminfo
set selectmode=mouse
"
" Maps
"=====
"
" F10
"====
" C in-line comment
" Insert mode map
map! <F10> /*  */2hi
" Command mode map
map <F10> i/*  */2hi
"
" F9
"===
" Comment out line
map! <F9> ^i/* A */
map <F9> ^i/* A */
"
" F8
"===
"Insert #ifdef _TEST_ around line
map! <F8> Oi#ifdef _TEST_joi#endif
map <F8> Oi#ifdef _TEST_joi#endif
"
" F7 -> ()
"=========
map! <F7> (  )hha
map <F7> i()ha
"
" F6 -> { }
"==========
map! <F6> 
{
}O
map <F6> o{
}O
"
" F5
"===
" Compile and link
map! <F5> :set makeprg=ml
:make
map <F5> :set makeprg=ml
:make %
"
" F4
"===
" Just compile the library
map! <F4> :set makeprg=md
:make %
map <F4> :set makeprg=md
:make %
"
" F3
"===
" Submit file to sql
map! <F3> :!sql -i % \| less
map <F3> :!sql -i % \| less
"
" F2
"===
" Append line to memo file
map! <F2> :.,.w >> memo
map <F2> :.,.w >> memo
" I like highlighting strings inside C comments
let c_comment_strings=1
" Switch on syntax highlighting.
syntax on
" Switch on search pattern highlighting.
set hlsearch
" Hide the mouse pointer while typing
set mousehide
" Set the terminal type
set term=$TERM











"=========================
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"Plugin 'Valloric/YouCompleteMe'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line



set hlsearch
set incsearch
"set tags=/home-nfs/ibutt/githome/mf/tags,~/githome/phnx/build-debug
"set tags+=/home-nfs/ibutt/githome/phnx/build-debug/tags.phx.build-dir,/home-nfs/ibutt/githome/phnx/build-debug/tags.phx.src-dir

set tags=~/githome/fxall_functional_complete/build_debug
set tags+=/home-nfs/ibutt/githome/fxall_functional_complete/build_debug/tags.phx.build-dir,/home-nfs/ibutt/githome/fxall_functional_complete/build_debug/tags.phx.src-dir

"cs add /home-nfs/ibutt/githome/phnx/build-debug/cscope.phx.out
"cs add /home-nfs/ibutt/githome/fxall_functional_complete/build_debug/cscope.out

"set path=/home-nfs/ibutt/githome/mf/Backend,.,/usr/include
"set path=.,/usr/include
set path=.

set hls
set t_Co=256
set noignorecase
set visualbell
" set autowrite
set ruler
set iskeyword=a-z,A-Z,48-57,_
set tabstop=4
set expandtab
"set softtabstop=4
set shiftwidth=4
"
"
"
set autoindent
set smartindent
"set cindent
"set shiftround

set tildeop
set history=5000
set ea!
" this allows you to type anywhere
"set virtualedit=all
set wildmenu
set wildmode=longest,list
set wildignore+=*.a,*.o
set laststatus=2
set statusline=%<%f\ \|%h%m%r%=%-14.(%l,%c%V%)\ %P
set term=xterm-256color
set shell=/usr/bin/zsh
:set fdo-=search

packadd! matchit

filetype plugin on
filetype plugin indent on

let loaded_matchparen=1

let g:ackprg = 'ag --smart-case --follow --column --numbers --cpp --vimgrep'
let g:ackhighlight = 1
let g:ackpreview = 1

let g:ycm_server_python_interpreter = '/usr/bin/python2'


" Turning this off for Vundle
"filetype on

syntax enable
colo busierbee

let g:bufExplorerSortBy='fullpath'   " Sort by full file path name.
let g:bufExplorerShowDirectories=0

"let messaging_version_path='build/rh7_3.'.$MESSAGING_VERSION.'.0/**'
"set path+=Backend/**
"execute 'set path+='.messaging_version_path
set path+=.,..
set path+=/home-nfs/ibutt/githome/fxall_functional_complete/gateways



if &diff
    " set background=light
    " diff mode
        syntax on
    colorscheme lucius
    set diffopt+=iwhite
    set diffexpr=DiffW()
    call feedkeys("\<C-L>")
endif

if !exists("*DiffW")
  function DiffW()
      let opt = ""
      if &diffopt =~ "icase"
        let opt = opt . "-i "
      endif
      if &diffopt =~ "iwhite"
        let opt = opt . "-w " " vim uses -b by default
      endif
      silent execute "!diff -a --binary " . opt .
        \ v:fname_in . " " . v:fname_new .  " > " . v:fname_out
  endfunction
endif

" vp doesn't replace paste buffer
function! RestoreRegister()
  let @" = s:restore_reg
  return ''
endfunction
function! s:Repl()
  let s:restore_reg = @"
  return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

augroup file_type
autocmd!
augroup END
let mapleader = "\<Space>"

nnoremap <leader>fn :let @" = expand("%")
nnoremap <leader>hl :set hlsearch!<CR>
nnoremap <leader>ca :set ic!<CR>
nnoremap <leader>wr :set wrap!<CR>0
nnoremap <leader>li :set list!<CR>
nnoremap <leader>pa :set paste!<CR>
nnoremap <leader>bl :set background=light<CR>
nnoremap <leader>bd :set background=dark<CR>
nnoremap <leader>vv :vs<CR>
nnoremap <leader>hh :split<CR>
nnoremap <leader>wa :Obsess<CR>:wa<CR>
nnoremap <leader>dt :diffthis<CR>
nnoremap <leader>do :diffoff!<CR>
nnoremap <leader>rn :set rnu!<CR>
nnoremap <leader>so :so ~/.vimrc<CR>
nnoremap <leader>re :bufdo e!<CR>:so ~/.vimrc<CR>
nnoremap <leader>cf :w<CR>:!clang-format -i -style=google %<CR>:e!<CR>
nnoremap <leader>as :w<CR>:!astyle %<CR>:e!<CR>
nnoremap <leader>ds :r !date<CR>
nnoremap <leader>ci jjjyy1GPdtWf-;Dj0
" next|previous diff & center
nnoremap <leader>cn ]cz.
nnoremap <leader>cp [cz.
nnoremap <leader>to :tabe %<CR>
nnoremap <leader>tc :tabc<CR>
nnoremap <leader>nu :set number!<CR>
nnoremap <leader>ne :new<CR>
nnoremap <leader>vn :vnew<CR>
nnoremap <leader>qq :Obsess<CR>:q!<CR>
nnoremap <leader>zz :Obsess<CR>:wqa<CR>
nnoremap <leader>qa :Obsess<CR>:qa<CR>
nnoremap <leader>mk :Obsess<CR>
nnoremap <leader>H :vertical resize -20<CR>
nnoremap <leader>L :vertical resize +20<CR>
nnoremap <leader>J :resize +10<CR>
nnoremap <leader>K :resize -10<CR>
nnoremap <leader>sy :set syntax=cpp<CR>
" reload current buffer
nnoremap <leader>ee :e!<CR>
nnoremap <leader>bc :.bc -l<CR>
nnoremap <leader>ag :Ack!<CR>
" yank first!
nnoremap <leader>ga :Ack!<C-R>0<CR>
nnoremap <leader>sh :Obsess<CR>:sh<CR>
" repeat last ex cmd:
nnoremap <leader>:: @:<CR>
" fold all but matching search
" "nnoremap <leader>fs :setlocal
" foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2
" foldmethod=expr foldlevel=0
" "nnoremap <leader>sf :setlocal
" foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2
" foldmethod=expr foldlevel=0 foldcolumn=2<CR>
nnoremap <leader>fm :FoldMatching<CR>
nnoremap <leader>mf :FoldNotMatching<CR>
" 'da'sh line
nnoremap <leader>da o<ESC>80i-<ESC>
nnoremap <leader>ma :make -j32<bar>copen<CR>
"--------------------------------------------------------------------------------
let g:netrw_bufsettings="noma nomod rn nobl nowrap ro"
let g:netrw_list_hide= '.*\.swp$'
""--------------------------------------------------------------------------------
let g:foldutilClearFolds=0

set foldmethod=syntax
""set foldlevelstart=1
"let xml_syntax_folding=1
""au FileType xml setlocal foldmethod=syntax
set nofoldenable    " disable folding


nmap <F5> :make -j10<CR>
nmap <F8> :cn<CR>



"---------------------- settings for python files
"- taken from https://realpython.com/vim-and-python-a-match-made-in-heaven/
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |
    \ set softtabstop=4

"Flagging Unnecessary Whitespace
highlight BadWhitespace ctermbg=red guibg=darkred

au BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.cpp,*.hpp match BadWhitespace /\s\+$/

set encoding=utf-8
