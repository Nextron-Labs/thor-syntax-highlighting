" THOR APT Scanner - Log File Syntax Highlighting for Vim
" Maintainer: Nextron Systems GmbH
" URL: https://github.com/Nextron-Labs/thor-syntax-highlighting
" License: MIT

if exists("b:current_syntax")
  finish
endif

syntax case match
syntax sync fromstart

" === Comments ===
syntax match thorComment /^\s*#.*$/

" === Timestamps (anchored to start of line) ===
syntax match thorTimestamp /^\w\{3}\s\+\d\{1,2}\s\+\d\{2}:\d\{2}:\d\{2}/
syntax match thorTimestamp /^\d\{4}-\d\{2}-\d\{2}T\d\{2}:\d\{2}:\d\{2}/

" === Hashes (must match before other words - they're very specific) ===
syntax match thorHashSHA256 /\<\x\{64}\>/
syntax match thorHashSHA1   /\<\x\{40}\>/
syntax match thorHashMD5    /\<\x\{32}\>/

" === Scan IDs ===
syntax match thorScanID /\<S-[A-Za-z0-9_-]\+\>/

" === Field keys (WORD:) - defined early, but will be overridden ===
syntax match thorFieldKey /\<[A-Z_][A-Z0-9_]*:/

" === Source (THOR: / THOR_UTIL:) - more specific, defined AFTER FieldKey ===
syntax match thorSource /\<THOR\(_UTIL\)\?:/

" === Log levels - more specific, defined AFTER FieldKey ===
syntax match thorLevelAlert   /\<Alert:/
syntax match thorLevelError   /\<Error:/
syntax match thorLevelWarning /\<Warning:/
syntax match thorLevelNotice  /\<Notice:/
syntax match thorLevelInfo    /\<Info:/

" === IP addresses ===
syntax match thorIPAddress /\d\{1,3}\.\d\{1,3}\.\d\{1,3}\.\d\{1,3}/

" === Hostname/IP (word after space, before source) ===
" This should match PROMETHEUS in "PROMETHEUS/10.0.2.15"
syntax match thorHostIP /\/\d\{1,3}\.\d\{1,3}\.\d\{1,3}\.\d\{1,3}/ contains=thorIPAddress
syntax match thorHost /\s\zs[A-Za-z][A-Za-z0-9._-]*\ze\%([\/\s]\|$\)/

" === Numbers ===
syntax match thorNumber /: \zs\d\+\ze/

" === Highlighting ===
highlight default link thorTimestamp  Number
highlight default link thorHost       Identifier
highlight default link thorHostIP     Special
highlight default link thorSource     Keyword
highlight default thorLevelAlert      ctermfg=Red    guifg=#f38ba8 cterm=bold gui=bold
highlight default thorLevelError      ctermfg=Magenta guifg=#cba6f7
highlight default thorLevelWarning    ctermfg=Yellow  guifg=#f9e2af
highlight default thorLevelNotice     ctermfg=Blue    guifg=#89b4fa
highlight default thorLevelInfo       ctermfg=Green   guifg=#a6e3a1
highlight default link thorFieldKey   Type
highlight default link thorHashMD5    Special
highlight default link thorHashSHA1   Special
highlight default link thorHashSHA256 Special
highlight default link thorIPAddress  Constant
highlight default link thorScanID     Constant
highlight default link thorNumber     Number
highlight default link thorComment    Comment

let b:current_syntax = "thorlog"