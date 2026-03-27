" THOR APT Scanner - Filetype detection for Vim
" Maintainer: Nextron Systems GmbH
" URL: https://github.com/Nextron-Labs/thor-syntax-highlighting
" License: MIT

" Detect by filename patterns
autocmd BufNewFile,BufRead *.thor.log,*.thor.txt setfiletype thorlog

" Detect by content: look for THOR log line pattern in first 20 lines
" THOR logs may start with comment lines, so check multiple lines
autocmd BufNewFile,BufRead *.log,*.txt
  \ if search('\mTHOR\(_UTIL\)\?:\s\+\(Alert\|Warning\|Notice\|Info\|Error\):', 'n', 20) > 0 |
  \   setfiletype thorlog |
  \ endif

" Also check files with hostname_thor_date patterns
autocmd BufNewFile,BufRead *_thor_*.log,*_thor_*.txt setfiletype thorlog
autocmd BufNewFile,BufRead *_THOR_*.log,*_THOR_*.txt setfiletype thorlog