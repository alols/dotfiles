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

" Use ~ like an operator
set tildeop

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

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Switch syntax highlighting on
syntax on
" Switch on highlighting the last used search pattern.
set hlsearch

" Use solarized colorscheme with the GUI and URxvt
if has("gui_running") || $COLORTERM=="rxvt-xpm"
    set t_Co=16
    set background=dark
    colorscheme solarized
else
    colorscheme default
endif

" Use lots of undo
set undolevels=1000

" Use an undodir if persistant undo is available
if has("persistent_undo")
    set undodir=~/.vim/undodir
    set undofile
    set undoreload=10000
endif

runtime macros/matchit.vim "Extended % matching
set wildmenu "better tab-completion
set wildmode=list:longest

fun! __svenska_()
    set kmp=swedish
endfun

"use terminal title
set title

" Browse buffers with PageUp, PageDown
nnoremap <silent> <PageDown> :bn<CR>
nnoremap <silent> <PageUp>   :bN<CR>

" Home opens the first buffer, End opens the last
nnoremap <silent> <Home>     :bf<CR>
nnoremap <silent> <End>      :bl<CR>

" Insert opens the first modified buffer
nnoremap <silent> <Insert>   :bm<CR>

" Delete opens the first error in the quickfix list
nnoremap <silent> <Delete>   :cr<CR>

" Navigate quickfix list with Up and Down keys
nnoremap <silent> <Down>     :cn<CR>
nnoremap <silent> <Up>       :cp<CR>

" F2 toggles paste
set pastetoggle=<F2>

" F3 toggles mouse and numbers off
" This is useful when Vim cannot access
" the X clipboard
set nu mouse=a
fun! __toggleMouse ()
    if &mouse=='a'
        set nonu mouse=
        echo "Mouse and numbers disabled"
    else
        set nu mouse=a
        echo "Mouse and numbers enabled"
    endif
endfun
command! InvMouse call __toggleMouse()
nnoremap <silent> <F3> :InvMouse<CR>

 " F4 toggles list
set list listchars=tab:→\ ,eol:↩,trail:\ ,extends:…,precedes:…
nnoremap <silent> <F4> :set invlist<CR>

" If you've opened a file w/o write persmission
" this lets you save it
command! WriteForce %!sudo tee > /dev/null %

" Use this when editing text where paragraphs should not contain newlines
command! SoftLine :set spell spelllang=sv,en nolist wrap linebreak tw=0 fo= showbreak=

" Use this when editing text where paragraphs should automatically
" have newlines inserted at the 74th column
command! HardLine :set spell spelllang=sv,en nolist nowrap nolinebreak tw=74 fo=tqan1

" Use this for editing code
command! Code :set nospell list wrap nolinebreak tw=74 fo=cqnr1 showbreak=…

" Code is default mode
Code


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

