" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Init pathogen
call pathogen#runtime_append_all_bundles() 
call pathogen#helptags() 

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup      " do not keep a backup file, use versions instead
else
  set backup        " keep a backup file
endif
set history=50      " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch       " do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au! 

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent        " always set autoindenting on

endif " has("autocmd")



" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

set hidden "buffers can be hidden without complaints
runtime macros/matchit.vim "Extended % matching
set wildmenu "better tab-completion
set wildmode=list:longest

"only ignore case when there are no capital letters in pattern
set ignorecase
set smartcase

"use terminal title
set title

set nu
set statusline=%f%r%m%=%Y\ %{&ff}\ %((%l/%L)%)\ %P
set laststatus=2
set tabstop=4
set shiftwidth=4
set expandtab
filetype on
filetype plugin on


map Y y$

fun! __cppSplit_()
if &filetype == "cpp"
    if expand("%:e") == "cpp"
        sp %:r.h
    elseif expand("%:e") == "h"
        sp %:r.cpp
        wincmd J
    endif
endif
endfun

nmap <silent> <Leader>s :call __cppSplit_()<cr>

set undolevels=1000
if has("persistent_undo")
    set undodir=~/.vim/undodir
    set undofile
    set undoreload=10000
endif

if has("gui_running") || $COLORTERM=="rxvt-xpm"
    set t_Co=16
    set background=dark
    colorscheme solarized
else
    colorscheme default
endif

set grepprg=ack

fun! __svenska_()
    set kmp=swedish
endfun

 " If you've opened a file w/o write persmission
 " this lets you save it
command! WForce %!sudo tee > /dev/null %

" use ~ like an operator
set tildeop

command! SoftProse :set spell spelllang=sv,en nolist wrap linebreak tw=0 fo= showbreak=
command! UnProse :set nospell list wrap nolinebreak tw=74 fo=cqnr1 showbreak=…
command! HardProse :set spell spelllang=sv,en nolist nowrap nolinebreak tw=74 fo=tqan1 showbreak=…

UnProse

nnoremap <silent> <PageDown> :bn<CR>
nnoremap <silent> <PageUp>   :bN<CR>
nnoremap <silent> <Home>     :bf<CR>
nnoremap <silent> <End>      :bl<CR>

nnoremap <silent> <Down>     :cn<CR>
nnoremap <silent> <Up>       :cp<CR>

nnoremap <silent> <Right>    :n<CR>
nnoremap <silent> <Left>     :N<CR>

nnoremap <silent> <Insert>   :bm<CR>

 " F4 toggles list
set listchars=tab:▸\ ,eol:⏎,trail:\ ,extends:…,precedes:…
nnoremap <silent> <F4> :set invlist<CR>

 " F3 toggles mouse
fun! __toggleMouse ()
    if &mouse=='a'
        set nonu mouse=
        echo "Mouse disabled"
    else
        set nu mouse=a
        echo "Mouse enabled"
    endif
endfun
command! InvMouse call __toggleMouse()
nnoremap <silent> <F3> :InvMouse<CR>

 " F2 toggles number and relative number
fun! __toggleNu()
    if &nu
        set rnu
    elseif &rnu
        set nu
    endif
endfun
nmap <silent> <F2> :call __toggleNu()<cr>

set pastetoggle=<F12>
