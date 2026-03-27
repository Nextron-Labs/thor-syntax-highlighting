# THOR Log — Emacs

Syntax highlighting for [THOR APT Scanner](https://www.nextron-systems.com/thor/) text log files.

## Installation

### Via MELPA (Recommended)

> *Coming soon* — once this package is registered with MELPA.

### Using use-package + straight.el

```elisp
(use-package thorlog-mode
  :straight (:host github :repo "Nextron-Labs/thor-syntax-highlighting"
             :files ("emacs/thorlog-mode.el")))
```

### Using use-package + Quelpa

```elisp
(use-package thorlog-mode
  :quelpa (thorlog-mode :fetcher github
           :repo "Nextron-Labs/thor-syntax-highlighting"
           :files ("emacs/thorlog-mode.el")))
```

### Using Doom Emacs

Add to `packages.el`:

```elisp
(package! thorlog-mode
  :recipe (:host github :repo "Nextron-Labs/thor-syntax-highlighting"
           :files ("emacs/thorlog-mode.el")))
```

### Manual Installation

1. Copy `thorlog-mode.el` to your Emacs load path (e.g. `~/.emacs.d/lisp/`):

   ```bash
   mkdir -p ~/.emacs.d/lisp
   cp emacs/thorlog-mode.el ~/.emacs.d/lisp/
   ```

2. Add to your init file (`~/.emacs.d/init.el` or `~/.emacs`):

   ```elisp
   (add-to-list 'load-path "~/.emacs.d/lisp")
   (require 'thorlog-mode)
   ```

## File Association

The mode auto-detects files with the extensions `.thor.log` and `.thor.txt`, and files whose first line matches the THOR log format.

For other files, activate the mode manually:

```
M-x thorlog-mode
```

Or add a file-local variable at the end of the log file:

```
# Local Variables:
# mode: thorlog
# End:
```

Or add a pattern to your init file:

```elisp
(add-to-list 'auto-mode-alist '("_thor_.*\\.\\(txt\\|log\\)\\'" . thorlog-mode))
```

## Customization

All faces belong to the `thorlog` customization group. Customize them with:

```
M-x customize-group RET thorlog RET
```

Or set them in your init file:

```elisp
(set-face-attribute 'thorlog-level-alert nil :foreground "red" :weight 'bold)
(set-face-attribute 'thorlog-level-warning nil :foreground "orange")
(set-face-attribute 'thorlog-field-key nil :foreground "sea green")
(set-face-attribute 'thorlog-hash nil :foreground "medium purple")
```

## What Gets Highlighted

| Element | Face | Default Inherits |
|---------|------|-----------------|
| Timestamps | `thorlog-timestamp` | `font-lock-constant-face` |
| Hostnames | `thorlog-hostname` | `font-lock-variable-name-face` |
| Source (`THOR:`) | `thorlog-source` | `font-lock-keyword-face` |
| Alert / Error | `thorlog-level-alert` / `thorlog-level-error` | `error` |
| Warning | `thorlog-level-warning` | `warning` |
| Notice | `thorlog-level-notice` | `font-lock-function-name-face` |
| Info | `thorlog-level-info` | `font-lock-comment-face` |
| Field keys | `thorlog-field-key` | `font-lock-type-face` |
| Hashes | `thorlog-hash` | `font-lock-string-face` |
| IP addresses | `thorlog-ip-address` | `font-lock-constant-face` |
| Scan IDs | `thorlog-scan-id` | `font-lock-constant-face` |
| Numbers | `thorlog-number` | `font-lock-constant-face` |

All faces adapt to your color theme. They use standard `font-lock` faces as defaults for maximum compatibility.
