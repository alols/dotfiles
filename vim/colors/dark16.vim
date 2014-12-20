" vim:ts=8:sts=8:noet:tw=90:nolist
"
" Minimal dark color scheme for 16-color terminals that just works
"
" Author: Albin Olsson
" URL: https://github.com/alols/dotfiles/blob/master/vim/colors/dark16.vim

set background=dark

hi! clear

if exists("syntax_on")
  syntax reset
endif

let colors_name="dark16"


" Default highlight groups

hi! Normal	ctermfg=white		ctermbg=black		cterm=none

hi! CursorLine	ctermfg=none		ctermbg=darkgray	cterm=none
hi! link	CursorColumn	CursorLine
hi! link	ColorColumn	CursorLine

" Surroundings
hi! LineNr		ctermfg=lightgray	ctermbg=darkgray	cterm=none
hi! CursorLineNr	ctermfg=cyan		ctermbg=none		cterm=none
hi! StatusLineNC	ctermfg=darkcyan	ctermbg=black		cterm=none
hi! StatusLine		ctermfg=cyan		ctermbg=darkgray	cterm=none
hi! VertSplit		ctermfg=darkgray	ctermbg=darkgray	cterm=none
hi! TabLine		ctermfg=lightgray	ctermbg=darkgray	cterm=none
hi! TabLineSel		ctermfg=white		ctermbg=darkgray	cterm=none
hi! TabLineFill		ctermfg=none		ctermbg=darkgray	cterm=none
hi! link SignColumn	LineNr
hi! link FoldColumn	LineNr

" Diff
hi! DiffAdd	ctermfg=none		ctermbg=darkgray	cterm=none
hi! DiffDelete	ctermfg=red		ctermbg=darkgray	cterm=none
hi! DiffChange	ctermfg=none		ctermbg=darkgray	cterm=none
hi! DiffText	ctermfg=magenta		ctermbg=darkgray	cterm=underline

hi! MatchParen	ctermfg=none		ctermbg=darkmagenta	cterm=none

" Marked text
hi! Visual	ctermfg=black		ctermbg=darkmagenta	cterm=none
hi! link	IncSearch	Visual
hi! link	Search		IncSearch

hi! Folded	ctermfg=cyan	ctermbg=darkgray		cterm=none

" Pop-up menu
hi! Pmenu	ctermfg=lightgray	ctermbg=darkgray	cterm=none
hi! PmenuSBar	ctermfg=none		ctermbg=darkgray	cterm=none
hi! PmenuThumb	ctermfg=none		ctermbg=lightgray	cterm=none
hi! link	PmenuSel	Visual

" Spell checker
hi! SpellBad	ctermfg=red		ctermbg=none		cterm=underline
hi! SpellCap	ctermfg=green		ctermbg=none		cterm=underline
hi! SpellLocal	ctermfg=magenta		ctermbg=none		cterm=underline
hi! SpellRare	ctermfg=cyan		ctermbg=none		cterm=underline

hi! Directory	ctermfg=blue		ctermbg=none		cterm=none

" Prompts and warnings
hi! Title	ctermfg=darkcyan	ctermbg=none		cterm=bold
hi! ErrorMsg	ctermfg=white		ctermbg=darkred		cterm=bold
hi! link	WarningMsg	ErrorMsg
hi! link	Question	MoreMsg
hi! link	WildMenu	Visual
hi! link	MoreMsg		Title
hi! link	ModeMsg		MoreMsg

hi! link	SpecialKey	NonText
hi! NonText	ctermfg=lightgray	ctermbg=none		cterm=none

" Syntax
hi! Comment	ctermfg=lightgray	ctermbg=none		cterm=none

hi! Constant	ctermfg=darkcyan	ctermbg=none		cterm=none

hi! Identifier	ctermfg=blue		ctermbg=none		cterm=none
hi! Function	ctermfg=darkblue	ctermbg=none		cterm=none

hi! Statement	ctermfg=darkgreen	ctermbg=none		cterm=none
hi! Label	ctermfg=green		ctermbg=none		cterm=none
hi! Operator	ctermfg=darkmagenta	ctermbg=none		cterm=none
hi! link	Exception	Label

hi! PreProc	ctermfg=red		ctermbg=none		cterm=none
hi! Macro	ctermfg=magenta		ctermbg=none		cterm=none

hi! Type	ctermfg=darkyellow	ctermbg=none		cterm=none
hi! Structure	ctermfg=yellow		ctermbg=none		cterm=none
hi! Typedef	ctermfg=yellow		ctermbg=none		cterm=bold
hi! link	StorageClass	Structure

hi! Special	ctermfg=darkred		ctermbg=none		cterm=none
hi! SpecialChar ctermfg=cyan		ctermbg=none		cterm=bold
hi! Tag		ctermfg=none		ctermbg=none		cterm=bold,underline
hi! link	SpecialComment Constant

hi! Ignore	ctermfg=darkgray	ctermbg=black		cterm=none

hi! Error	ctermfg=red		ctermbg=none		cterm=bold
hi! Todo	ctermfg=white		ctermbg=darkmagenta	cterm=bold
