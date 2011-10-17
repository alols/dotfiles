" TODO
" Does not work when CD'd out of project dir
" Add method for adding files to project
" Detect and resolve scopes
" Rewrite python part in vimscript

fun! VimProLoad(project)
    let g:ProjectDir = fnamemodify(a:project, ":p:h")
    let g:ProjectFile = fnamemodify(a:project, ":p:t")
    let g:ProjectTags = "tags"
    exec "set tags=".g:ProjectDir."/".g:ProjectTags
    exec "cd ".g:ProjectDir
python << endpython
import vim

values = { 'SOURCES' : [],
          'HEADERS' : [],
          'INCLUDEPATH' : [],
          'OTHER_FILES' : []}
lastline = ''
with open(vim.eval("g:ProjectFile")) as f:
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

fun! ProGrep(grepcommand)
    let grepcommand = "vimgrep ".a:grepcommand
    for s in g:VimProPro.VIM_GREP
        let grepcommand = grepcommand.' '.join(g:VimProPro[s], ' ')
    endfor
    echom grepcommand
    try
        exec grepcommand
    catch /E480/
        echom "Pattern not found in project"
        return
    endtry
    exec "2match Search ".substitute(a:grepcommand, "\\(^/.*/\\).*$", "\\1", "")
endfun
command! -nargs=1 ProGr call ProGrep("<args>")

fun! ProGrepWord(word)
    normal! gew
    call ProGrep("/\\<".a:word."\\>/gj")
endfun
nmap <F9> :call ProGrepWord(expand("<cword>"))<cr>
nmap <F10> :cc 1<cr>

fun! VimProTagUpdate(file)
    if exists("g:ProjectTags")
        silent exec "keepalt sp ".g:ProjectDir.'/'.g:ProjectTags
        silent lcd %:h
        let file = fnamemodify(a:file, ":.")
        silent exec "g/".escape(file,'/')."/d"
        silent w
        " TODO ctags command line depends on filetype
        silent exec "!ctags -f ".fnamemodify(g:ProjectTags, ":t")." -a ".file
        silent bd
    endif
endfun

augroup Pro
    au!
    autocmd BufWritePost * call VimProTagUpdate(expand("<afile>"))
    autocmd BufRead *.pro call VimProLoad(expand("<afile>"))
augroup END
