" THOR APT Scanner - Root-level ftdetect wrapper
" Sources the actual ftdetect from vim/ subdirectory
" This enables plugin managers (vim-plug, etc.) without needing 'rtp'

let s:dir = expand('<sfile>:p:h:h') . '/vim/ftdetect/thorlog.vim'
if filereadable(s:dir)
  execute 'source ' . s:dir
endif
