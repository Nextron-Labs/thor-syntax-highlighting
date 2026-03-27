" THOR APT Scanner - Log File Syntax Highlighting for Vim
" Maintainer: Nextron Systems GmbH
" URL: https://github.com/NextronSystems/thor-syntax-highlighting
" License: MIT

if exists("b:current_syntax")
  finish
endif

syntax case match

" === Syslog timestamp ===
syntax match thorTimestamp /^\(\w\{3}\s\+\d\{1,2}\s\+\d\{2}:\d\{2}:\d\{2}\|\d\{4}-\d\{2}-\d\{2}T\d\{2}:\d\{2}:\d\{2}[^ ]*\)/ nextgroup=thorHost skipwhite

" === Hostname/IP ===
syntax match thorHost /\S\+/ contained nextgroup=thorSource skipwhite

" === Source (THOR / THOR_UTIL) ===
syntax match thorSource /THOR\(_UTIL\)\?:/ contained nextgroup=thorLevel skipwhite

" === Log levels ===
syntax match thorLevelAlert /Alert:/ contained nextgroup=thorFieldRegion skipwhite
syntax match thorLevelError /Error:/ contained nextgroup=thorFieldRegion skipwhite
syntax match thorLevelWarning /Warning:/ contained nextgroup=thorFieldRegion skipwhite
syntax match thorLevelNotice /Notice:/ contained nextgroup=thorFieldRegion skipwhite
syntax match thorLevelInfo /Info:/ contained nextgroup=thorFieldRegion skipwhite
syntax cluster thorLevel contains=thorLevelAlert,thorLevelError,thorLevelWarning,thorLevelNotice,thorLevelInfo

" === Field region (rest of line after level) ===
syntax region thorFieldRegion start=/\S/ end=/$/ contained contains=thorFieldKey,thorHashSHA256,thorHashSHA1,thorHashMD5,thorIPAddress,thorScanID,thorNumber

" === Field keys ===
" Field names from https://github.com/NextronSystems/jsonlog
" Includes optional relation prefix (e.g. PARENT_) and numeric suffix (e.g. _1)
syntax match thorFieldKey /\<\([A-Z][A-Z0-9]*_\)\?\(ACCESSED\|ACCESS_COUNT\|ACTIVE\|ACTIVE_FEATURES\|ACTIVE_MODULES\|ADDRESS\|AFFECTED\|ALLOW\|APPNAME\|APPPATH\|APP_INFO\|ARCH\|ARGUMENTS\|AUTHENTICATED_USER_NAME\|AUTHOR\|AUTH_PACKAGE\|AUTORUN_TYPE\|BACKGROUND_BYTES_READ\|BACKGROUND_BYTES_WRITTEN\|BACKGROUND_NUM_READ_OPERATIONS\|BACKGROUND_NUM_WRITE_OPERATIONS\|BAD_PASSWORD_COUNT\|BEACON\|BEACON_LENGTH\|BEACON_OFFSET\|BIRTH_VOLUME_ID\|BLOCK_START\|BUILD\|BUILD_NUMBER\|BUILD_SEQUENCE_ID\|C2\|CALLBACK_INTERVAL\|CAPTION\|CATEGORY\|CERTIFICATE_NAME\|CHANGED\|CHECKSUM\|CHUNK_END\|CHUNK_OFFSET\|CIPHER_PARAMETERS\|CLIENT\|CLIENT_NAME\|CLIENT_TYPE\|COMMAND\|COMMAND_LINE\|COMMENT\|COMPANY\|COM_HANDLER\|CONNECTIONS\|CONNECTION_COUNT\|CONTENT\|COUNT\|CPU_COUNT\|CPU_LIMIT\|CREATED\|DATA\|DATE\|DATE_ACCESS\|DEAD\|DELETED\|DELETION_TIME\|DESC\|DESCRIPTION\|DIR\|DOMAIN\|DURATION\|ELEMENT\|ELEMENT1\|ELEMENT2\|ELEVATED\|ENABLED\|END_TIME\|ENTRIES\|ENTRY\|ENTRY_ID\|ERROR\|ERRORS\|EVENT\|EVENTCONSUMER\|EVENTCONSUMERNAME\|EVENTFILTER\|EVENTFILTERNAME\|EVENTNAME\|EVENTTYPE\|EVENT_CHANNEL\|EVENT_COMPUTER\|EVENT_ID\|EVENT_LEVEL\|EVENT_TIME\|EXCLUSION\|EXE\|EXECUTABLE\|EXECUTION_COUNT\|EXEC_FLAG\|EXISTS\|EXPIRES\|EXTENSION\|EXTRAS\|FACE_TIME\|FAILURE_COMMAND\|FALSEPOSITIVES\|FAULT_IN_MODULE\|FILE\|FILENAME\|FILE_SIZE_LIMIT\|FILTERTYPE\|FIRSTBYTES\|FIRST_RUN\|FIRST_SUBMISSION\|FLAGS\|FOREGROUND_BYTES_READ\|FOREGROUND_BYTES_WRITTEN\|FOREGROUND_NUM_READ_OPERATIONS\|FOREGROUND_NUM_WRITE_OPERATIONS\|FREE_MEMORY_LIMIT\|FULL_NAME\|GROUP\|GROUPID\|GUID\|HANDLE\|HASH\|HDR_MOD\|HIVEFILE\|HOME\|HOOK\|HOST\|HOSTNAME\|IAT_HOOKED\|ID\|IDLE\|IGNORED\|IMAGE\|IMPHASH\|IMPLANTED\|INBOUND\|INCLUDED_IN_KERNEL\|INJECTION_PROCESS\|INSERT_DATE\|INSTALLED_ON\|INTERFACE\|INTERNAL_NAME\|IN_PROC_MODULES\|IN_SYS_MODULE\|IN_VMALLOCINFO\|IP\|IP_ADDRESS\|IS_ADMIN\|KERNEL_NAME\|KERNEL_VERSION\|KEY\|KEYWORD\|KEY_NAME\|LANGUAGE\|LASTRUN\|LAST_ACCESS\|LAST_HOTFIX\|LAST_LOGON\|LAST_RESULT\|LAST_RUN\|LAST_STOPPED\|LAST_SUBMISSION\|LAUNCH_STRING\|LEGAL_COPYRIGHT\|LICENSE\|LINE\|LINK_TYPE\|LIP\|LISTEN_PORTS\|LOAD_TIME\|LOCATION\|LOCKED\|LOGON_TIME\|LOGON_TYPE\|LPORT\|LSA_SESSION\|MATCHED\|MD5\|MD5_BEFORE\|MEMORY\|MESSAGE\|MFT_FILE_NAME_ACCESSED\|MFT_FILE_NAME_CHANGED\|MFT_FILE_NAME_CREATED\|MFT_FILE_NAME_MODIFIED\|MODEL\|MODIFIED\|MODULE\|MUTEX\|NAME\|NAMES\|NESTED\|NETBIOS_NAME\|NEXTRUN\|NO_EXPIRE\|NUM_LOGONS\|NUM_OPENS\|OBJECT_ID\|ORIGINAL_FILENAME\|ORIGINAL_NAME\|OS_BUILD_TIME\|OTHER\|OTHER_DOMAINS\|OWNER\|PAIRWISE_SWAPPED\|PARAMETERS\|PARENT\|PARENT_COMMAND\|PASSWORD\|PASS_AGE\|PATCHED\|PATH\|PERMISSIONS\|PE_SIEVE\|PID\|PINNED\|PIPE\|PIPENAME\|PIPES\|PORT\|PPID\|PREVIOUS_ENTRIES\|PRIMARY_KEY\|PRIORITY\|PRIVILEGES\|PROC\|PROCESS\|PRODUCT\|PRODUCT_NAME\|PROTOCOL\|PROXY\|REASON\|REASONS_COUNT\|REF\|REPLACED\|REPORTTYPE\|RESULT\|RIP\|ROLE_GUID\|ROLE_NAME\|RPORT\|RULE\|RULEDATE\|RULENAME\|RUN_AS_GROUP\|RUN_AS_USER\|RUN_LEVEL\|SCANID\|SCANNER\|SCAN_ID\|SCHEDULE\|SCORE\|SERVER\|SERVICE_NAME\|SERVICE_PACK\|SERVICE_TYPE\|SESSION\|SHA1\|SHA256\|SHARE_NAME\|SHARE_PERMS\|SHELL\|SIGCLASS\|SIGMA_VERSION\|SIGNATURE_STATUS\|SIGNATURE_VALID\|SIGNATURE_VERSION\|SIGNED\|SIGTYPE\|SIZE\|SKIPPED\|SPAWNTO\|STARTED\|STARTS\|START_TYPE\|STATUS\|SUBELEMENT1\|SUBELEMENT2\|SUBFIELD1\|SUBFIELD2\|SUBFIELD3\|SUBFIELD4\|SUBFIELD5\|SUBFIELD8\|SUBMISSIONS\|SUBOBJECT\|SUBSCORE\|SUBSTRUCT\|SUSPICIOUS_SECTIONS\|SYMBOL\|SYSTEM_TYPE\|TAG\|TAGS\|TARGET\|TARGET_SIZE\|TECHNOLOGY_LEVEL\|TENANT_ID\|THOR_DIR\|THREADS\|THREAD_ID\|THREAT\|THREAT_NAME\|TIME\|TIMEOUT\|TIMESTAMP\|TIMEZONE\|TITLE\|TOTAL_ACCESSES\|TREE\|TRIGGERS\|TYPE\|UID\|UNEXPANDED\|UNIT\|UNPACK_SOURCE\|UNREACHABLE_FILE\|UPTIME\|URL\|USER\|USERID\|USERNAME\|USER_AGENT\|USER_NAME\|USER_SID\|USN_CHANGE_TIME\|VALUE\|VALUER\|VALUES\|VAR\|VCPUS\|VERDICTS\|VERSION\|VIRUSTOTAL\|VOLUME_ID\|XAF_ENCODED\|XAF_ENCODING_ANCHOR\|XOR_KEY\)\(_\d\+\)\?\>:\ze / contained

" === Hashes ===
syntax match thorHashSHA256 /\<[0-9a-fA-F]\{64}\>/ contained
syntax match thorHashSHA1 /\<[0-9a-fA-F]\{40}\>/ contained
syntax match thorHashMD5 /\<[0-9a-fA-F]\{32}\>/ contained

" === IP addresses ===
syntax match thorIPAddress /\<\d\{1,3}\.\d\{1,3}\.\d\{1,3}\.\d\{1,3}\>/ contained

" === Scan IDs ===
syntax match thorScanID /\<S-[a-zA-Z0-9_-]\+\>/ contained

" === Numbers (after colon-space, likely scores/sizes) ===
syntax match thorNumber /: \zs\d\+\ze\(\s\|$\)/ contained

" === Comments ===
syntax match thorComment /^\s*#.*$/

" === Highlighting ===
highlight default link thorTimestamp  Number
highlight default link thorHost       Identifier
highlight default link thorSource     Keyword
highlight default thorLevelAlert   ctermfg=Red    guifg=#f38ba8 cterm=bold gui=bold
highlight default thorLevelError   ctermfg=Magenta guifg=#cba6f7
highlight default thorLevelWarning ctermfg=Yellow  guifg=#f9e2af
highlight default thorLevelNotice  ctermfg=Blue    guifg=#89b4fa
highlight default thorLevelInfo    ctermfg=Green   guifg=#a6e3a1
highlight default link thorFieldKey   Type
highlight default link thorHashSHA256 Special
highlight default link thorHashSHA1   Special
highlight default link thorHashMD5    Special
highlight default link thorIPAddress  Constant
highlight default link thorScanID     Constant
highlight default link thorNumber     Number
highlight default link thorComment    Comment

let b:current_syntax = "thorlog"
