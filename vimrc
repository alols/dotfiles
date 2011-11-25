" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Init pathogen plugin
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Make Y move like D and C
map Y y$

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Keep a backup file
set backup

" Buffers can be hidden without complaints
set hidden

set shiftwidth=4    " Set indentation step to four spaces
set expandtab       " Turn tab key presses into spaces in insert mode
set softtabstop=4   " Insert four spaces with every tab press
set tabstop=8       " Let an actual tab character be repesented by
                    " eight spaces

set history=500      " keep 500 lines of command line history
set ruler            " show the cursor position all the time
set showcmd          " display incomplete commands
set incsearch        " do incremental searching

" Allways show status line
set statusline=%f%r%m%=%Y\ %{&ff}\ %((%l/%L)%)\ %P
set laststatus=2

" Don't use two spaces after a sentence when joining lines.
set nojoinspaces

" Switch syntax highlighting on.
syntax on

" Use solarized colorscheme with the GUI and URxvt.
if has("gui_running") || $COLORTERM=="rxvt-xpm"
    set t_Co=16
    set background=dark
    colorscheme solarized
else
    colorscheme default
endif

" Use lots of undo.
set undolevels=1000

" Use an undodir if persistant undo is available.
if has("persistent_undo")
    set undodir=~/.vim/undodir
    set undofile
    set undoreload=10000
endif

" Tab-completion on the command line.
set wildmenu
set wildmode=list:longest

"use terminal title.
set title
set titleold="[terminal]"

" Navigate quickfix list with PageUp and PageDown keys
nnoremap <silent> <PageDown> :cn<CR>
nnoremap <silent> <PageUp>   :cN<CR>

" Home opens the first error, End opens the last
nnoremap <silent> <Home>     :cr<CR>
nnoremap <silent> <End>      :cla<CR>

" Left and right switches matching tags.
" Up and Down moves you up and down the tag-stack.
nnoremap <silent> <Right>    :tn<CR>
nnoremap <silent> <Left>     :tN<CR>
nnoremap <silent> <Down>     :po<CR>
nnoremap <silent> <Up>       :ta<CR>


" F2 toggles paste
set pastetoggle=<F2>

" F3 toggles mouse and numbers off
" This is useful when Vim cannot access
" the X clipboard
set nu mouse=a
fun! __toggleMouse ()
    if &mouse=='a'
        set nonu mouse=
        echom "Mouse and numbers disabled"
    else
        set nu mouse=a
        echom "Mouse and numbers enabled"
    endif
endfun
command! InvMouse call __toggleMouse()
nnoremap <silent> <F3> :InvMouse<CR>
inoremap <silent> <F3> <Esc>:InvMouse<CR>a

 " F4 toggles list
set list listchars=tab:→\ ,eol:↩,trail:\ ,extends:…,precedes:…
nnoremap <silent> <F4> :setlocal invlist<CR>
inoremap <silent> <F4> <Esc>:setlocal invlist<CR>a

" F5 toggles using Swedish special characters when typing
" on an American keyboard (Affects insert mode only)
fun! __svenska()
    if &kmp=="swedish"
        set kmp=
    else
        set kmp=swedish
    endif
endfun
command! Svenska call __svenska()
nnoremap <silent> <F5> :Svenska<CR>
inoremap <silent> <F5> <Esc>:Svenska<CR>a


" If you've opened a file w/o write persmission
" this lets you save it
command! WriteForce %!sudo tee > /dev/null %


" When writing prose, it is useful to put undo breaks after each sentence
" work in progess!!
command! -bar Prose inoremap <buffer> . .<C-G>u|
            \ inoremap <buffer> ! !<C-G>u|
            \ inoremap <buffer> ? ?<C-G>u
command! -bar NoProse silent iunmap <buffer> .|
            \ silent iunmap <buffer> !|
            \ silent iunmap <buffer> ?

" Use this when editing text where paragraphs should not contain newlines
command! SoftLine Prose| setlocal spell spelllang=sv,en
    \ nolist wrap linebreak tw=0 fo= showbreak= nonu

" Use this when editing text where paragraphs should automatically
" have newlines inserted at the 74th column
command! HardLine Prose| setlocal spell spelllang=sv,en
    \ nolist nowrap nolinebreak tw=74 fo=tqan1 nonu

" Use this for editing code
command! Code NoProse| setlocal nospell list wrap nolinebreak
    \ tw=74 fo=cqnr1 showbreak=… nu

" Code is default mode
Code


" Some GPG commands
" Sign range
command! -range=% Sig <line1>,<line2>!gpg -ats
" Encrypt and sign range
command! -range=% Enc <line1>,<line2>!gpg -atse
" Decryt/Verify range
command! -range=% Dec <line1>,<line2>!gpg -atd
" Strip range of leading ">"
command! -range=% Str <line1>,<line2>s/^> *//


" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " When editing a file, always jump to the last known cursor position.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent        " always set autoindenting on

endif " has("autocmd")
