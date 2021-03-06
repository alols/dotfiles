" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Init vim-plug
call plug#begin('~/.vim/plugged')

Plug 'mhinz/vim-signify'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-dispatch'
Plug 'godlygeek/tabular'
Plug 'Rip-Rip/clang_complete'
Plug 'vim-scripts/UltiSnips'
Plug 'tpope/vim-markdown'
Plug 'nelstrom/vim-markdown-folding'
Plug 'benmills/vimux'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-lua-ftplugin'
Plug 'alols/vim-love-efm'
Plug 'majutsushi/tagbar'
Plug 'alepez/vim-gtest'
Plug 'aklt/plantuml-syntax'
Plug 'kien/ctrlp.vim'
Plug 'tjennings/git-grep-vim'

" Add plugins to &runtimepath
call plug#end()

" Enable file type detection
filetype plugin indent on

" Make Y move like D and C
noremap Y y$

" Use Q to format a paragraph
noremap Q gwip

" Use space to toggle folds
nnoremap <Space> za

" Set undo break before deleting with C-U
inoremap <C-U> <C-G>u<C-U>

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Buffers can be hidden without complaints
set hidden

set shiftwidth=4    " Set indentation step to four spaces
set expandtab       " Turn tab key presses into spaces in insert mode
set softtabstop=4   " Insert four spaces with every tab press
set tabstop=4       " Let an actual tab character be repesented by
                    " four spaces

set history=500     " Keep 500 lines of command line history.
set ruler           " Show the cursor position all the time.
set showcmd         " Display incomplete commands.

" Set all columns past textwidth as color column
execute "set colorcolumn=+".join(range(1,255),',+')

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

" folding
set foldmethod=indent
set foldcolumn=2
set foldnestmax=1
set foldminlines=2
set foldtext=

if &term=~"xterm" || &term=~"screen"
    set t_Co=16
    colorscheme dark16
endif

" Switch syntax highlighting on.
syntax on

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

" Insert mode completion
set completeopt=menuone

"use terminal title.
set title
set titleold=[terminal]

"Fix for xcape
inoremap <C-k> <Esc>k

" I prefer vertical splitting over horizontal
let s:verticalMode=0
fun! s:toggleVerticalMode()
    if !s:verticalMode
        set splitright
        set winwidth=80
        cabbrev h vert help
        cabbrev sp vsp
        cabbrev hsp sp
        set diffopt+=vertical
        let s:verticalMode=1
    else
        set nosplitright
        set winwidth=20
        unabbrev h
        cabbrev  h help
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
set statusline+=%{fugitive#statusline()}\ \|\  " Git branch
set statusline+=%{strlen(&ft)?&ft.'\ \|\ ':''} " Filetype
set statusline+=%{strlen(&fenc)?&fenc.'\ ':''} " Encoding
set statusline+=%{&ff=='unix'?'^n':&ff=='dos'?'^r^n':'^r'} "Lineendings
set statusline+=\ \|\ %4l,\ %2c\               " Row, Col

set fillchars=

" When writing prose, it is useful to put undo breaks after each sentence
command! Prose inoremap <buffer> . .<C-G>u|
            \ inoremap <buffer> ! !<C-G>u|
            \ inoremap <buffer> ? ?<C-G>u|
            \ setlocal spell spelllang=sv,en
            \     nolist nowrap tw=79 fo=t1 nonu|
            \ augroup PROSE|
            \   autocmd InsertEnter <buffer> set fo+=a|
            \   autocmd InsertLeave <buffer> set fo-=a|
            \ augroup END

command! Code silent! iunmap <buffer> .|
            \ silent! iunmap <buffer> !|
            \ silent! iunmap <buffer> ?|
            \ setlocal nospell list nowrap
            \     tw=79 fo=cqr1 showbreak=… nu|
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
let g:clang_complete_macros=1
let g:clang_library_path="/usr/lib/llvm-3.4/lib"
"these two enables error checking
let g:clang_complete_copen=1
let g:clang_hl_errors=1

" m is really nice for custom mappings, who uses marks anyway?

noremap ml :<C-u>CtrlPMRU<CR>
let g:ctrlp_map = 'mf'

noremap mp :<C-u>call VimuxPromptCommand()<CR>
noremap mr :<C-u>call VimuxRunLastCommand()<CR>

noremap mc :<C-U>call g:ClangUpdateQuickFix()<CR>

noremap mt :<C-U>TagbarToggle<CR>
noremap mm :<C-U>Make<CR>

noremap ma :<C-U>Ack 
noremap mg :<C-U>GitGrep 


" Some GPG commands
" Sign range
command! -range=% Sig <line1>,<line2>!gpg -ats
" Encrypt and sign range
command! -range=% Enc <line1>,<line2>!gpg -atse
" Decryt/Verify range
command! -range=% Dec <line1>,<line2>!gpg -atd
" Strip range of leading ">"
command! -range=% Str <line1>,<line2>s/^> *//

" Found this online and modified it a bit.
" If jumping beyond last window try to jump to tmux split instead.
" Also see tmux.conf
if exists('$TMUX')
  function! TmuxOrSplitSwitch(wincmd, tmuxdir)
    let previous_winnr = winnr()
    silent! execute "wincmd " . a:wincmd
    if previous_winnr == winnr()
      call system("tmux select-pane -" . a:tmuxdir)
      redraw!
    endif
  endfunction
  noremap <silent> <Left>  :<C-u>call TmuxOrSplitSwitch('h', 'L')<cr>
  noremap <silent> <Down>  :<C-u>call TmuxOrSplitSwitch('j', 'D')<cr>
  noremap <silent> <Up>    :<C-u>call TmuxOrSplitSwitch('k', 'U')<cr>
  noremap <silent> <Right> :<C-u>call TmuxOrSplitSwitch('l', 'R')<cr>
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    augroup vimrcEx
        au!
        " When editing a file, always jump to the last known cursor position.
        autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif

        " When starting a diff, jump to the top.
        autocmd FilterWritePost *
          \ if &diff |
          \   exe "normal! gg" |
          \ endif

        " Lets be faithful to out line editor heritage
        if &t_Co == 16
            set cursorline
            autocmd WinEnter * set cursorline
            autocmd WinLeave * set nocursorline
        endif

    augroup END

else

  set autoindent        " always set autoindenting on

endif " has("autocmd")

au BufNewFile,BufRead *.qml			setf qml |
        \ set tw=0 |
        \ normal zi


let s:privdir = expand('~/Private')
if finddir(s:privdir) != ""
    " Private directory exists
    if 0 == match(getcwd(), s:privdir)
        " Vim launched inside private directory
        " Location of viminfo-file (must be last viminfo-setting)
        set viminfo+=n~/Private/.viminfo
        " Location of undo files
        set undodir=~/Private/tmp/vimundo
        " Location of swapfile, '.' = same dir as file
        set directory=.,~/Private/tmp
    else
        " Vim launched outside of private directory
        " Don't allow editing of files in private
        augroup privateDirAu
            au!
            execute 'autocmd BufRead '.s:privdir.'/* bd |
                        \ echoerr "Tried to open file under '.s:privdir.' from outside of it"'
        augroup END
    endif
endif

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
