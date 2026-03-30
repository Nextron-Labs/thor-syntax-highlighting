" THOR APT Scanner - Filetype detection for Vim
" Maintainer: Nextron Systems GmbH
" URL: https://github.com/Nextron-Labs/thor-syntax-highlighting
" License: MIT

" Detect by filename patterns
" Uses 'setlocal filetype=' to override Vim's built-in 'text' detection for .txt files
autocmd BufNewFile,BufRead *.thor.log,*.thor.txt setlocal filetype=thorlog

" Also check files with hostname_thor_date patterns
autocmd BufNewFile,BufRead *_thor_*.log,*_thor_*.txt setlocal filetype=thorlog
autocmd BufNewFile,BufRead *_THOR_*.log,*_THOR_*.txt setlocal filetype=thorlog

" Detect by content: look for THOR log line pattern in first 20 lines
" Uses getline() instead of search() to avoid side effects (search register, cursor)
autocmd BufNewFile,BufRead *.log,*.txt call s:DetectThorLog()

function! s:DetectThorLog()
  let l:max = min([20, line('$')])
  for l:i in range(1, l:max)
    if getline(l:i) =~# '\mTHOR\(_UTIL\)\?:\s\+\(Alert\|Warning\|Notice\|Info\|Error\):'
      setlocal filetype=thorlog
      return
    endif
  endfor
endfunction
