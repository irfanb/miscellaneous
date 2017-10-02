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
set errorformat=%f:%l:\ %m
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
map! <F6> {}O
map <F6> o{}O
"
" F5
"===
" Compile and link
map! <F5> :set makeprg=ml:make
map <F5> :set makeprg=ml:make %
"
" F4
"===
" Just compile the library
map! <F4> :set makeprg=md:make %
map <F4> :set makeprg=md:make %
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











