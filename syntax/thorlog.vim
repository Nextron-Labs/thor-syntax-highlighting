" THOR APT Scanner - Root-level syntax wrapper
" Sources the actual syntax from vim/ subdirectory
" This enables plugin managers (vim-plug, etc.) without needing 'rtp'

let s:dir = expand('<sfile>:p:h:h') . '/vim/syntax/thorlog.vim'
if filereadable(s:dir)
  execute 'source ' . s:dir
endif
