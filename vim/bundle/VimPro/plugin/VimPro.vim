" TODO
" Auto update tags file (check out AutoTag)
" Add method for adding files to project
" Detect and resolve scopes

fun! VimProLoad(project)
    let g:ProjectDir = fnamemodify(a:project, ":p:h")
    let g:ProjectTags = g:ProjectDir."/tags"
    exec "set tags=".eval("g:ProjectTags")
python << endpython
import vim

values = { 'SOURCES' : [],
          'HEADERS' : [],
          'INCLUDEPATH' : [],
          'OTHER_FILES' : []}
lastline = ''
with open(vim.eval("a:project")) as f:
   for line in f:
       line = ' '.join((lastline, line.rstrip()))
       if line.endswith("\\"):
           lastline = line.rstrip('\\')
           continue
       else:
           lastline = ''

       line = line.partition('#')[0]

       tokens = []

       while '"' in line:
           part = line.partition('"')
           tokens += part[0].split()
           part = part[2].partition('"')
           tokens.append(part[0])
           line = part[2]

       tokens += line.split()

       if not tokens:
           continue
       if len(tokens) < 3:
           raise Exception

       if tokens[0] not in values.keys():
           values[tokens[0]] = []

       if tokens[1] == '=':
           values[tokens[0]] = tokens[2:]
       elif tokens[1] == '+=':
           for token in tokens[2:]:
               if token not in values[tokens[0]]:
                   values[tokens[0]].append(token)
       elif tokens[1] == '-=':
           for token in tokens[2:]:
               if token in values[tokens[0]]:
                   values[tokens[0]].remove(token)

values['__INCLUDES__'] = [path + '/*.h' for path in values['INCLUDEPATH']]

vim.command("let g:VimProPro =" + str(values))
endpython

    exec "!ctags -f ".g:ProjectTags." --c++-kinds=+pl --fields=+iaS --extra=+q"
            \ join(g:VimProPro.SOURCES, ' ')
            \ join(g:VimProPro.HEADERS, ' ')
            \ join(g:VimProPro.__INCLUDES__, ' ')
endfun

fun! VimProGrep(word)
   normal! gew
   try
       exec "vimgrep /\\<".a:word."\\>/gj"
               \ join(g:VimProPro.SOURCES, ' ')
               \ join(g:VimProPro.HEADERS, ' ')
               \ join(g:VimProPro.OTHER_FILES, ' ')
   catch
       return
   endtry
   let l:nr = 1
   for hit in getqflist()
       let l:nr = l:nr + 1
       if hit.bufnr == bufnr("%")
               \ && hit.lnum == line(".")
               \ && col(".") == hit.col
           break
       endif
   endfor
   if l:nr <= len(getqflist())
       exec "cc".l:nr
   else
       exec "cc 1"
   endif
   exec "match Search /\\<".a:word."\\>/"
endfun
nmap <F9> :call VimProGrep(expand("<cword>"))<cr>
nmap <F10> :cc 1<cr>

fun! VimProTagUpdate(file)
    if exists("g:ProjectTags")
        silent exec "keepalt sp ".g:ProjectTags
        silent lcd %:h
        let file = fnamemodify(a:file, ":.")
        silent exec "g/".escape(file,'/')."/d"
        silent w
        " TODO ctags command line depends on filetype
        silent exec "!ctags -f ".g:ProjectTags."--c++-kinds=+pl --fields=+iaS --extra=+q -a ".file
        silent bd
    endif
endfun

augroup Pro
    au!
    autocmd BufWritePost * call VimProTagUpdate(expand("<afile>"))
augroup END
