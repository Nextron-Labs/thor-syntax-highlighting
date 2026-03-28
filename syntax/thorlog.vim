" THOR APT Scanner - Root-level syntax wrapper
" Sources the actual syntax definition from vim/ subdirectory

let s:vim_syntax = expand('<sfile>:p:h:h') . '/vim/syntax/thorlog.vim'
if filereadable(s:vim_syntax)
  execute 'source ' . fnameescape(s:vim_syntax)
endif
