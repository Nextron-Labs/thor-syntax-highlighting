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
" Syslog format: Jan 21 18:14:34
syntax match thorTimestamp /^\w\{3}\s\+\d\{1,2}\s\+\d\{2}:\d\{2}:\d\{2}/
" RFC3339 format: 2024-03-20T08:22:00Z
syntax match thorTimestamp /^\d\{4}-\d\{2}-\d\{2}T\d\{2}:\d\{2}:\d\{2}/

" === Hashes (very specific patterns - match before general words) ===
syntax match thorHashSHA256 /\<\x\{64}\>/
syntax match thorHashSHA1   /\<\x\{40}\>/
syntax match thorHashMD5    /\<\x\{32}\>/

" === Scan IDs (S-xxxxx) ===
syntax match thorScanID /\<S-[A-Za-z0-9_-]\+\>/

" === Field keys (UPPERCASE_WORD: with space or value after) ===
syntax match thorFieldKey /\<[A-Z_][A-Z0-9_]*:/

" === Source keyword (THOR: / THOR_UTIL:) — defined AFTER FieldKey to win priority ===
syntax match thorSource /\<THOR\(_UTIL\)\?:/

" === Log levels — defined AFTER FieldKey to win priority ===
syntax match thorLevelAlert   /\<Alert:/
syntax match thorLevelError   /\<Error:/
syntax match thorLevelWarning /\<Warning:/
syntax match thorLevelNotice  /\<Notice:/
syntax match thorLevelInfo    /\<Info:/

" === Hostname/IP — positional match between timestamp and THOR: ===
" Matches: "ion.local/192.168.178.175" or "PROMETHEUS/10.0.2.15" or "WORKSTATION"
" Only in the header portion (after timestamp, before THOR:)
syntax match thorHostIP /\/\d\{1,3}\.\d\{1,3}\.\d\{1,3}\.\d\{1,3}\ze\s\+THOR\(_UTIL\)\?:/
syntax match thorHost /\d\{2}:\d\{2}:\d\{2}\s\+\zs[A-Za-z0-9][A-Za-z0-9._-]*\ze[\/\s]\+.*THOR\(_UTIL\)\?:/

" === IP addresses (standalone, not part of hostname) ===
syntax match thorIPAddress /\<\d\{1,3}\.\d\{1,3}\.\d\{1,3}\.\d\{1,3}\>/

" === Numbers (only after field key "KEY: 123") ===
syntax match thorNumber /:\s\+\zs\d\+\ze\s/

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
