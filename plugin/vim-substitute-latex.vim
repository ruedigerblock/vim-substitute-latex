" Title:        Vim Substitude Latex
" Description:  A plugin that substitudes LaTeX names into UTF-8 Symbols
" Last Change:  09.03.2025
" Maintainer:   Rüdiger Block <https://github.com/ruedigerblock/>

if exists("g:loaded_vim_substitute_latex")
    finish
endif
let g:loaded_vim_subsitute_latex = 1

let s:script_path = expand('<sfile>:h')
let s:dict={}

let s:lines = readfile(s:script_path.'/latex_symbols.txt')
for line in s:lines
  let lines_split = split(line, ' ')
  let latex = lines_split[0]
  let symbol = lines_split[-1]
  let s:dict[latex] = symbol
endfor

function! s:ReplaceLaTeXWithSymbols()
  let save_ic = &ic
  set noic
  let &ic = save_ic
  if has_key(v:completed_item, 'word')
    let word = v:completed_item["word"]
    if has_key(s:dict, word)
      let last = getcharpos('.')

      silent! execute 's/' . "\\" . word . '/' . s:dict[word] . '/g'

      call setcursorcharpos(last[1], last[2])
      call search(s:dict[word], 'b')
      let last = getcharpos('.')
      call setcursorcharpos(last[1], last[2] + 1)
    endif
  endif
endfunction

function! LatexSymbolCompletor(opt, ctx) abort
  let l:col = a:ctx['col']
  let l:typed = a:ctx['typed']
  let l:kw = matchstr(l:typed, '\v\S+$')
  let l:kwlen = len(l:kw)
  let l:startcol = l:col - l:kwlen
  let l:matches = keys(s:dict)

  call asyncomplete#complete(a:opt['name'], a:ctx, l:startcol, l:matches)
endfunction

augroup ReplaceLaTeXWithSymbols
    autocmd!
    autocmd CompleteDone * call s:ReplaceLaTeXWithSymbols()
augroup END

