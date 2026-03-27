" THOR APT Scanner - Filetype detection for Vim
" Detect by filename patterns
autocmd BufNewFile,BufRead *.thor.log,*.thor.txt setfiletype thorlog

" Detect by content: look for THOR log line pattern in first 10 lines
autocmd BufNewFile,BufRead *.log,*.txt
  \ if getline(1) =~# 'THOR\(_UTIL\)\?:\s\+\(Alert\|Warning\|Notice\|Info\|Error\):' ||
  \    getline(2) =~# 'THOR\(_UTIL\)\?:\s\+\(Alert\|Warning\|Notice\|Info\|Error\):' ||
  \    getline(3) =~# 'THOR\(_UTIL\)\?:\s\+\(Alert\|Warning\|Notice\|Info\|Error\):' |
  \   setfiletype thorlog |
  \ endif
