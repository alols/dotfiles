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
hi! NonText		ctermfg=lightgray	ctermbg=darkgray	cterm=none
hi! StatusLine		ctermfg=cyan		ctermbg=darkgray	cterm=none
hi! link	StatusLineNC	NonText
hi! VertSplit		ctermfg=darkgray	ctermbg=darkgray	cterm=none
hi! link	LineNr		NonText
hi! link	CursorLineNr	StatusLine
hi! link	SignColumn	NonText
hi! link	TabLine		NonText
hi! link	TabLineSel	StatusLine
hi! link	TabLineFill	VertSplit

" Diff
hi! DiffAdd	ctermfg=cyan		ctermbg=darkgray	cterm=bold
hi! DiffDelete	ctermfg=magenta		ctermbg=darkgray	cterm=none
hi! DiffChange	ctermfg=none		ctermbg=darkgray	cterm=none
hi! DiffText	ctermfg=cyan		ctermbg=darkgray	cterm=bold

hi! MatchParen	ctermfg=none		ctermbg=darkmagenta	cterm=none

" Marked text
hi! Visual	ctermfg=black		ctermbg=white		cterm=none
hi! IncSearch	ctermfg=black		ctermbg=darkmagenta	cterm=none
hi! link	Search		IncSearch

hi! Folded	ctermfg=none	ctermbg=none		cterm=underline
hi! FoldColumn	ctermfg=white	ctermbg=darkgray	cterm=none

" Pop-up menu
hi! Pmenu	ctermfg=white		ctermbg=darkgray	cterm=none
hi! PmenuSBar	ctermfg=none		ctermbg=darkgray	cterm=none
hi! PmenuThumb	ctermfg=none		ctermbg=lightgray	cterm=none
hi! link	PmenuSel	IncSearch

" Spell checker
hi! SpellBad	ctermfg=none		ctermbg=none		cterm=underline
hi! link	SpellCap	SpellBad
hi! link	SpellLocal	SpellBad
hi! link	SpellRare	SpellBad

hi! Directory	ctermfg=blue		ctermbg=none		cterm=none

" Prompts and warnings
hi! Title	ctermfg=darkcyan	ctermbg=none		cterm=bold
hi! ErrorMsg	ctermfg=white		ctermbg=darkred		cterm=bold
hi! link	WarningMsg	ErrorMsg
hi! link	Question	MoreMsg
hi! link	WildMenu	IncSearch
hi! link	MoreMsg		Title
hi! link	ModeMsg		MoreMsg

hi! link	SpecialKey	NonText

" Syntax
hi! Comment	ctermfg=lightgray	ctermbg=none		cterm=none

hi! Constant	ctermfg=darkcyan	ctermbg=none		cterm=none

hi! Identifier	ctermfg=blue		ctermbg=none		cterm=none
hi! Function	ctermfg=darkblue	ctermbg=none		cterm=none

hi! Statement	ctermfg=darkgreen	ctermbg=none		cterm=none
hi! Label	ctermfg=green		ctermbg=none		cterm=none
hi! Operator	ctermfg=magenta		ctermbg=none		cterm=none
hi! link	Exception	Label

hi! PreProc	ctermfg=red		ctermbg=none		cterm=none
hi! Macro	ctermfg=darkred		ctermbg=none		cterm=none

hi! Type	ctermfg=darkyellow	ctermbg=none		cterm=none
hi! Structure	ctermfg=yellow		ctermbg=none		cterm=none
hi! link	Typedef		Structure
hi! link	StorageClass	Structure

hi! Special	ctermfg=magenta		ctermbg=none		cterm=none
hi! SpecialChar ctermfg=cyan		ctermbg=none		cterm=bold
hi! Tag		ctermfg=magenta		ctermbg=none		cterm=underline
hi! SpecialComment	ctermfg=darkmagenta	ctermbg=none	cterm=none

hi! Ignore	ctermfg=darkgray	ctermbg=black		cterm=none

hi! Error	ctermfg=red		ctermbg=none		cterm=bold
hi! Todo	ctermfg=white		ctermbg=darkmagenta	cterm=bold
