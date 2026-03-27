;;; thorlog-mode.el --- Major mode for THOR APT Scanner text logs -*- lexical-binding: t; -*-

;; Author: Nextron Systems GmbH
;; URL: https://github.com/NextronSystems/thor-syntax-highlighting
;; Version: 1.0.0
;; Keywords: languages, logs, security
;; Package-Requires: ((emacs "24.3"))

;; This file is not part of GNU Emacs.

;; MIT License
;; Copyright (c) 2024 Nextron Systems GmbH

;;; Commentary:

;; Syntax highlighting for THOR APT Scanner text log files.
;; Field names derived from https://github.com/NextronSystems/jsonlog
;;
;; Highlights timestamps, hostnames, IP addresses, log levels,
;; field keys, hashes (MD5/SHA1/SHA256), scan IDs, and numeric values.
;;
;; Auto-detects files with extensions .thor.log and .thor.txt.

;;; Code:

(defgroup thorlog nil
  "Major mode for THOR APT Scanner log files."
  :group 'languages
  :prefix "thorlog-")

;; Faces

(defface thorlog-timestamp
  '((t :inherit font-lock-constant-face))
  "Face for timestamps in THOR logs."
  :group 'thorlog)

(defface thorlog-hostname
  '((t :inherit font-lock-variable-name-face))
  "Face for hostnames in THOR logs."
  :group 'thorlog)

(defface thorlog-source
  '((t :inherit font-lock-keyword-face))
  "Face for THOR/THOR_UTIL source tag."
  :group 'thorlog)

(defface thorlog-level-alert
  '((((class color) (background dark))  :foreground "#f38ba8" :weight bold)
    (((class color) (background light)) :foreground "#d20f39" :weight bold)
    (t :inherit error :weight bold))
  "Face for Alert level (red, bold)."
  :group 'thorlog)

(defface thorlog-level-error
  '((((class color) (background dark))  :foreground "#cba6f7")
    (((class color) (background light)) :foreground "#8839ef")
    (t :inherit font-lock-constant-face))
  "Face for Error level (purple)."
  :group 'thorlog)

(defface thorlog-level-warning
  '((((class color) (background dark))  :foreground "#f9e2af")
    (((class color) (background light)) :foreground "#df8e1d")
    (t :inherit warning))
  "Face for Warning level (yellow)."
  :group 'thorlog)

(defface thorlog-level-notice
  '((((class color) (background dark))  :foreground "#89b4fa")
    (((class color) (background light)) :foreground "#1e66f5")
    (t :inherit font-lock-function-name-face))
  "Face for Notice level (blue)."
  :group 'thorlog)

(defface thorlog-level-info
  '((((class color) (background dark))  :foreground "#a6e3a1")
    (((class color) (background light)) :foreground "#40a02b")
    (t :inherit font-lock-string-face))
  "Face for Info level (green)."
  :group 'thorlog)

(defface thorlog-field-key
  '((t :inherit font-lock-type-face))
  "Face for field keys (MODULE:, MESSAGE:, etc.)."
  :group 'thorlog)

(defface thorlog-hash
  '((t :inherit font-lock-string-face))
  "Face for hash values (MD5, SHA1, SHA256)."
  :group 'thorlog)

(defface thorlog-ip-address
  '((t :inherit font-lock-constant-face))
  "Face for IP addresses."
  :group 'thorlog)

(defface thorlog-scan-id
  '((t :inherit font-lock-constant-face))
  "Face for scan IDs (S-xxxxx)."
  :group 'thorlog)

(defface thorlog-number
  '((t :inherit font-lock-constant-face))
  "Face for numeric values."
  :group 'thorlog)

;; Field names from THOR's jsonlog textlog tags.
;; Kept as a single regex alternation for performance.
(defconst thorlog--field-names-re
  (concat
   "\\<\\(?:[A-Z][A-Z0-9]*_\\)?"
   "\\(?:"
   "ACCESS\\(?:ED\\|_COUNT\\)\\|ACTIVE\\(?:_FEATURES\\|_MODULES\\)?\\|"
   "ADDRESS\\|AFFECTED\\|ALLOW\\|APP\\(?:NAME\\|PATH\\|_INFO\\)\\|"
   "ARCH\\|ARGUMENTS\\|AUTH\\(?:ENTICATED_USER_NAME\\|OR\\|_PACKAGE\\)\\|"
   "AUTORUN_TYPE\\|"
   "BACKGROUND_\\(?:BYTES_\\(?:READ\\|WRITTEN\\)\\|NUM_\\(?:READ\\|WRITE\\)_OPERATIONS\\)\\|"
   "BAD_PASSWORD_COUNT\\|BEACON\\(?:_LENGTH\\|_OFFSET\\)?\\|"
   "BIRTH_VOLUME_ID\\|BLOCK_START\\|BUILD\\(?:_NUMBER\\|_SEQUENCE_ID\\)?\\|"
   "C2\\|CALL\\(?:BACK_INTERVAL\\)\\|CAPTION\\|CATEGORY\\|"
   "CERTIFICATE_NAME\\|CHANGED\\|CHECKSUM\\|"
   "CHUNK_\\(?:END\\|OFFSET\\)\\|CIPHER_PARAMETERS\\|"
   "CLIENT\\(?:_NAME\\|_TYPE\\)?\\|COM\\(?:MAND\\(?:_LINE\\)?\\|MENT\\|PANY\\|_HANDLER\\)\\|"
   "CONNECTION\\(?:S\\|_COUNT\\)\\|CONTENT\\|COUNT\\|"
   "CPU_\\(?:COUNT\\|LIMIT\\)\\|CREATED\\|"
   "DATA\\|DATE\\(?:_ACCESS\\)?\\|DEAD\\|DELET\\(?:ED\\|ION_TIME\\)\\|"
   "DESC\\(?:RIPTION\\)?\\|DIR\\|DOMAIN\\|DURATION\\|"
   "EL\\(?:EMENT[12]?\\|EVATED\\)\\|ENABLED\\|END_TIME\\|"
   "ENTR\\(?:IES\\|Y\\(?:_ID\\)?\\)\\|ERROR\\(?:S\\)?\\|"
   "EVENT\\(?:CONSUMER\\(?:NAME\\)?\\|FILTER\\(?:NAME\\)?\\|NAME\\|TYPE\\|"
   "_\\(?:CHANNEL\\|COMPUTER\\|ID\\|LEVEL\\|TIME\\)\\)?\\|"
   "EXCLUSION\\|EXE\\(?:C\\(?:UTABLE\\|UTION_COUNT\\|_FLAG\\)\\)?\\|"
   "EXISTS\\|EXPIRES\\|EXTENSION\\|EXTRAS\\|"
   "FACE_TIME\\|FAILURE_COMMAND\\|FALSEPOSITIVES\\|FAULT_IN_MODULE\\|"
   "FILE\\(?:NAME\\|_SIZE_LIMIT\\)?\\|FILTERTYPE\\|FIRSTBYTES\\|"
   "FIRST_\\(?:RUN\\|SUBMISSION\\)\\|FLAGS\\|"
   "FOREGROUND_\\(?:BYTES_\\(?:READ\\|WRITTEN\\)\\|NUM_\\(?:READ\\|WRITE\\)_OPERATIONS\\)\\|"
   "FREE_MEMORY_LIMIT\\|FULL_NAME\\|"
   "GROUP\\(?:ID\\)?\\|GUID\\|"
   "HANDLE\\|HASH\\|HDR_MOD\\|HIVEFILE\\|HOME\\|HOOK\\|HOST\\(?:NAME\\)?\\|"
   "IAT_HOOKED\\|ID\\(?:LE\\)?\\|IGNORED\\|IMAGE\\|IMPHASH\\|IMPLANTED\\|"
   "INBOUND\\|INCLUDED_IN_KERNEL\\|INJECTION_PROCESS\\|"
   "IN\\(?:SERT_DATE\\|STALLED_ON\\|TERFACE\\|TERNAL_NAME\\|"
   "_\\(?:PROC_MODULES\\|SYS_MODULE\\|VMALLOCINFO\\)\\)\\|"
   "IP\\(?:_ADDRESS\\)?\\|IS_ADMIN\\|"
   "K\\(?:ERNEL_\\(?:NAME\\|VERSION\\)\\|EY\\(?:WORD\\|_NAME\\)?\\)\\|"
   "LANGUAGE\\|LAST\\(?:RUN\\|_\\(?:ACCESS\\|HOTFIX\\|LOGON\\|RESULT\\|RUN\\|STOPPED\\|SUBMISSION\\)\\)\\|"
   "LAUNCH_STRING\\|LEGAL_COPYRIGHT\\|LICENSE\\|LINE\\|LINK_TYPE\\|"
   "LIP\\|LISTEN_PORTS\\|LOAD_TIME\\|LOCATION\\|LOCKED\\|"
   "LOGON_\\(?:TIME\\|TYPE\\)\\|LPORT\\|LSA_SESSION\\|"
   "MATCHED\\|MD5\\(?:_BEFORE\\)?\\|MEMORY\\|MESSAGE\\|"
   "MFT_FILE_NAME_\\(?:ACCESSED\\|CHANGED\\|CREATED\\|MODIFIED\\)\\|"
   "MODEL\\|MODIFIED\\|MODULE\\|MUTEX\\|"
   "NAME\\(?:S\\)?\\|NESTED\\|NETBIOS_NAME\\|NEXTRUN\\|NO_EXPIRE\\|"
   "NUM_\\(?:LOGONS\\|OPENS\\)\\|"
   "OBJECT_ID\\|ORIGINAL_\\(?:FILENAME\\|NAME\\)\\|OS_BUILD_TIME\\|"
   "OTHER\\(?:_DOMAINS\\)?\\|OWNER\\|"
   "PAIRWISE_SWAPPED\\|PARAMETERS\\|PARENT\\(?:_COMMAND\\)?\\|"
   "PASS\\(?:WORD\\|_AGE\\)\\|PATCHED\\|PATH\\|PERMISSIONS\\|PE_SIEVE\\|"
   "PID\\|PINNED\\|PIPE\\(?:NAME\\|S\\)?\\|PORT\\|PPID\\|"
   "PREVIOUS_ENTRIES\\|PRIMARY_KEY\\|PRIORITY\\|PRIVILEGES\\|"
   "PROC\\(?:ESS\\)?\\|PRODUCT\\(?:_NAME\\)?\\|PROTOCOL\\|PROXY\\|"
   "REASON\\(?:S_COUNT\\)?\\|REF\\|REPLACED\\|REPORTTYPE\\|RESULT\\|"
   "RIP\\|ROLE_\\(?:GUID\\|NAME\\)\\|RPORT\\|"
   "RULE\\(?:DATE\\|NAME\\)?\\|RUN_\\(?:AS_\\(?:GROUP\\|USER\\)\\|LEVEL\\)\\|"
   "SCAN\\(?:ID\\|NER\\|_ID\\)\\|SCHEDULE\\|SCORE\\|SERVER\\|"
   "SERVICE_\\(?:NAME\\|PACK\\|TYPE\\)\\|SESSION\\|"
   "SHA\\(?:1\\|256\\|RE_\\(?:NAME\\|PERMS\\)\\)\\|SHELL\\|"
   "SIG\\(?:CLASS\\|MA_VERSION\\|NATURE_\\(?:STATUS\\|VALID\\|VERSION\\)\\|NED\\|TYPE\\)\\|"
   "SIZE\\|SKIPPED\\|SPAWNTO\\|START\\(?:ED\\|S\\|_TYPE\\)\\|STATUS\\|"
   "SUB\\(?:ELEMENT[12]\\|FIELD[1-5]\\|FIELD8\\|MISSIONS\\|OBJECT\\|SCORE\\|STRUCT\\)\\|"
   "SUSPICIOUS_SECTIONS\\|SYMBOL\\|SYSTEM_TYPE\\|"
   "TAG\\(?:S\\)?\\|TARGET\\(?:_SIZE\\)?\\|TECHNOLOGY_LEVEL\\|TENANT_ID\\|"
   "THOR_DIR\\|THREAD\\(?:S\\|_ID\\)\\|THREAT\\(?:_NAME\\)?\\|"
   "TIME\\(?:OUT\\|STAMP\\|ZONE\\)?\\|TITLE\\|TOTAL_ACCESSES\\|"
   "TREE\\|TRIGGERS\\|TYPE\\|"
   "UID\\|UNEXPANDED\\|UNIT\\|UNPACK_SOURCE\\|UNREACHABLE_FILE\\|"
   "UPTIME\\|URL\\|USER\\(?:ID\\|NAME\\|_\\(?:AGENT\\|NAME\\|SID\\)\\)?\\|"
   "USN_CHANGE_TIME\\|"
   "VALUE\\(?:R\\|S\\)?\\|VAR\\|VCPUS\\|VERDICTS\\|VERSION\\|VIRUSTOTAL\\|"
   "VOLUME_ID\\|"
   "XAF_ENCOD\\(?:ED\\|ING_ANCHOR\\)\\|XOR_KEY"
   "\\)"
   "\\(?:_[0-9]+\\)?:"
   )
  "Regexp matching THOR field keys (with optional prefix and numeric suffix).")

(defconst thorlog--font-lock-keywords
  `(
    ;; Comment lines
    ("^\\s-*#.*$" . font-lock-comment-face)

    ;; Syslog timestamp at start of line
    ("^\\([A-Z][a-z]\\{2\\}\\s-+[0-9]\\{1,2\\}\\s-+[0-9]\\{2\\}:[0-9]\\{2\\}:[0-9]\\{2\\}\\)"
     1 'thorlog-timestamp)

    ;; RFC3339 timestamp at start of line
    ("^\\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}T[0-9]\\{2\\}:[0-9]\\{2\\}:[0-9]\\{2\\}[^ ]*\\)"
     1 'thorlog-timestamp)

    ;; Source: THOR: or THOR_UTIL:
    ("\\<\\(THOR\\(?:_UTIL\\)?\\):" 1 'thorlog-source)

    ;; Log levels (order matters — most severe first)
    ("\\<\\(Alert\\):" 1 'thorlog-level-alert)
    ("\\<\\(Error\\):" 1 'thorlog-level-error)
    ("\\<\\(Warning\\):" 1 'thorlog-level-warning)
    ("\\<\\(Notice\\):" 1 'thorlog-level-notice)
    ("\\<\\(Info\\):" 1 'thorlog-level-info)

    ;; Field keys
    (,thorlog--field-names-re . 'thorlog-field-key)

    ;; SHA256 hashes (64 hex chars)
    ("\\<[0-9a-fA-F]\\{64\\}\\>" . 'thorlog-hash)

    ;; SHA1 hashes (40 hex chars)
    ("\\<[0-9a-fA-F]\\{40\\}\\>" . 'thorlog-hash)

    ;; MD5 hashes (32 hex chars)
    ("\\<[0-9a-fA-F]\\{32\\}\\>" . 'thorlog-hash)

    ;; IP addresses
    ("\\<[0-9]\\{1,3\\}\\.[0-9]\\{1,3\\}\\.[0-9]\\{1,3\\}\\.[0-9]\\{1,3\\}\\>" . 'thorlog-ip-address)

    ;; Scan IDs
    ("\\<S-[a-zA-Z0-9_-]+\\>" . 'thorlog-scan-id)

    ;; Numeric values after ": "
    (": \\([0-9]+\\)\\(?:\\s-\\|$\\)" 1 'thorlog-number)
    )
  "Font-lock keywords for `thorlog-mode'.")

;;;###autoload
(define-derived-mode thorlog-mode fundamental-mode "THOR-Log"
  "Major mode for viewing THOR APT Scanner text log files.

Provides syntax highlighting for timestamps, hostnames, log levels,
field keys, hashes, IP addresses, scan IDs, and numeric values.

\\{thorlog-mode-map}"
  (setq font-lock-defaults '(thorlog--font-lock-keywords nil nil))
  (setq-local comment-start "# ")
  (setq-local comment-end "")
  ;; Log files are typically read-only
  (setq buffer-read-only t))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.thor\\.\\(?:log\\|txt\\)\\'" . thorlog-mode))

;; Auto-detect by first line content
;;;###autoload
(add-to-list 'magic-mode-alist
             '("\\`\\(?:[A-Z][a-z]\\{2\\} +[0-9]\\{1,2\\} +[0-9:]\\{8\\}\\|[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}T\\).* THOR\\(?:_UTIL\\)?:" . thorlog-mode))

(provide 'thorlog-mode)

;;; thorlog-mode.el ends here
