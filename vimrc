" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Init NeoBundle
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#rc(expand('~/.vim/bundle'))

NeoBundle 'Shougo/vimproc'
NeoBundle 'mhinz/vim-signify'
NeoBundle 'mileszs/ack.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'Rip-Rip/clang_complete'
NeoBundle 'mikewest/vimroom'

" Enable file type detection
filetype plugin indent on

" Make Y move like D and C
noremap Y y$

" Use Q to format a paragraph
noremap Q gwip

" Set undo break before deleting with C-U
inoremap <C-U> <C-G>u<C-U>

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Buffers can be hidden without complaints
set hidden

set shiftwidth=4    " Set indentation step to four spaces
set expandtab       " Turn tab key presses into spaces in insert mode
set softtabstop=4   " Insert four spaces with every tab press
set tabstop=8       " Let an actual tab character be repesented by
                    " eight spaces

set history=500     " Keep 500 lines of command line history.
set ruler           " Show the cursor position all the time.
set showcmd         " Display incomplete commands.
set colorcolumn=+1  " Set color column = text width

" Being oldfashioned here.
set noincsearch     " Don't do incremental searching.
set nohlsearch      " Don't highlight search results.
set nowrapscan      " Don't wrap around file when searching.

" Don't use two spaces after a sentence when joining lines.
set nojoinspaces

" GUI options
" Must appear before syntax on.
" Autoselect, use icon, don't source menu.vim, left scrollbar.
set guioptions=aiML

" Use the '+' register as the unnamed register, to make cut and
" paste berween Vim and other applications easier
set clipboard=unnamedplus

" Put visually selected text in the '*' register
set clipboard+=autoselect

" Mice are nice
set mouse=a

" Switch syntax highlighting on.
syntax on

" Use solarized colorscheme with the GUI and URxvt.
if has("gui_running") || $COLORTERM=="rxvt-xpm" || $COLORTERM=="gnome-terminal"
    set t_Co=16
    set background=dark
    colorscheme solarized
else
    colorscheme default
endif

" Avoid delays in terminal
set ttm=50

" Use lots of undo.
set undolevels=1000

set cryptmethod=blowfish

" Use an undodir if persistant undo is available.
if has("persistent_undo")
    set undodir=~/.vim/undodir
    set undofile
    set undoreload=10000
else
    " Keep a backup file
    set backup
endif

" Tab-completion on the command line.
set wildmenu
set wildmode=list:longest

"use terminal title.
set title
set titleold=[terminal]

"Fix for xcape
inoremap <C-k> <Esc>k

" Navigate quickfix list with PageUp and PageDown keys
nnoremap <silent> <PageDown> :cn<CR>
nnoremap <silent> <PageUp>   :cN<CR>

" Toggle folds with Space
nnoremap <Space> za

" Home opens the first error, End opens the last
nnoremap <silent> <Home>     :cr<CR>
nnoremap <silent> <End>      :cla<CR>

" Left and right switches matching tags.
" Up and Down moves you up and down the tag-stack.
nnoremap <silent> <Right>    :tn<CR>
nnoremap <silent> <Left>     :tN<CR>
nnoremap <silent> <Down>     :po<CR>
nnoremap <silent> <Up>       :ta<CR>

" I prefer vertical splitting over horizontal
let s:verticalMode=0
fun! s:toggleVerticalMode()
    if !s:verticalMode
        set splitright
        set winwidth=80
        cabbrev help vert help
        cabbrev sp vsp
        cabbrev hsp sp
        set diffopt+=vertical
        let s:verticalMode=1
    else
        set nosplitright
        set winwidth=20
        unabbrev help
        unabbrev sp
        unabbrev hsp
        set diffopt-=vertical
        let s:verticalMode=0
    endif
endfun
command! ToggleVerticalMode call s:toggleVerticalMode()

if &columns > 150
    ToggleVerticalMode
endif

" R toggles relative number
set nu
fun! s:toggleRelativeNumber()
    if &nu
        set rnu
    else
        set nu
    endif
endfun
command! ToggleRelativeNumber call s:toggleRelativeNumber()
noremap R :ToggleRelativeNumber<CR>

" F2 toggles paste
set pastetoggle=<F2>

 " F4 toggles list
set list listchars=tab:→\ ,trail:\ ,extends:…,precedes:…
nnoremap <silent> <F4> :setlocal invlist<CR>
inoremap <silent> <F4> <C-o>:setlocal invlist<CR>

" F5 toggles using Swedish special characters when typing
" on an American keyboard (Affects insert mode only)
fun! s:svenska()
    if &kmp=="swedish"
        set kmp=
    else
        set kmp=swedish
    endif
endfun
command! Svenska call s:svenska()
nnoremap <silent> <F5> :Svenska<CR>
inoremap <silent> <F5> <C-o>:Svenska<CR>

" F6 toggles light/dark colors
fun! s:toggleColors()
    if &background=='light'
        set background=dark
    else
        set background=light
    endif
endfun
command! InvColors call s:toggleColors()
nnoremap <F6> :InvColors<CR>


" Statusline
set laststatus=2                               " Allways show
set statusline=%3n\                            " Buffer number
set statusline+=%{&ma?&ro?'=':'':'-'}          " Nomodifiable: -, Readonly: =
set statusline+=%{&mod?'+':'\ '}\              " Modified: +
set statusline+=\"%f\"\ %L\ lines%<%=          " Filename, nr lines
set statusline+=ts=%{&ts}\                     " Indention settings
set statusline+=%{&sts?'sts='.&sts.'\ ':''}    " Indention settings
set statusline+=sw=%{&sw}\ %{&et?'et\ ':''}\|\ " Indention settings
set statusline+=%{strlen(&ft)?&ft.'\ \|\ ':''} " Filetype
set statusline+=%{strlen(&fenc)?&fenc.'\ ':''} " Encoding
set statusline+=%{&ff=='unix'?'^n':&ff=='dos'?'^r^n':'^r'} "Lineendings
set statusline+=\ \|\ %4l,\ %2c\               " Row, Col


" When writing prose, it is useful to put undo breaks after each sentence
command! Prose inoremap <buffer> . .<C-G>u|
            \ inoremap <buffer> ! !<C-G>u|
            \ inoremap <buffer> ? ?<C-G>u|
            \ setlocal spell spelllang=sv,en
            \     nolist nowrap tw=74 fo=t1 nonu|
            \ augroup PROSE|
            \   autocmd InsertEnter <buffer> set fo+=a|
            \   autocmd InsertLeave <buffer> set fo-=a|
            \ augroup END

command! Code silent! iunmap <buffer> .|
            \ silent! iunmap <buffer> !|
            \ silent! iunmap <buffer> ?|
            \ setlocal nospell list nowrap
            \     tw=74 fo=cqr1 showbreak=… nu|
            \ silent! autocmd! PROSE * <buffer>

" Code is default mode
Code


" I use this to correct my spelling mistakes
nnoremap \s ea<C-X><C-S>

" Turn hard wrapped text into soft wrapped.
" This command will join all lines within a range that are not separated
" by empty lines. Automatic word wrap must be off (set fo-=a).
" Useful if you need to copy and paste into a word processor.
command! -range=% SoftWrap
            \ <line2>put _ |
            \ <line1>,<line2>g/.\+/ .;-/^$/ join |normal $x

"clang_complete settings
let g:clang_snippets=1
let g:clang_snippets_engine="ultisnips"

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

    augroup vimrcEx
        au!
        " When editing a file, always jump to the last known cursor position.
        autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif

        " Lets be faithful to out line editor heritage
        autocmd WinEnter * set cursorline
        autocmd WinLeave * set nocursorline

    augroup END

    set cursorline

else

  set autoindent        " always set autoindenting on

endif " has("autocmd")

" Check plugins
NeoBundleCheck
