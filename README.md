# THOR Log Syntax Highlighting

Syntax highlighting for [THOR APT Scanner](https://www.nextron-systems.com/thor/) text log files across multiple editors.

![THOR](https://www.nextron-systems.com/wp-content/uploads/2021/10/thor-logo.png)

## Supported Editors

| Editor | Directory | Status |
|--------|-----------|--------|
| [Sublime Text](sublime/) | `sublime/` | ✅ Ready |
| [Visual Studio Code](vscode/) | `vscode/` | ✅ Ready |
| [Vim / Neovim](vim/) | `vim/` | ✅ Ready |
| [Emacs](emacs/) | `emacs/` | ✅ Ready |
| [JetBrains IDEs](jetbrains/) | `jetbrains/` | ✅ Ready |

Each editor directory contains its own README with installation instructions.

## What Is This?

THOR produces text log files during scans. These logs follow a structured format with syslog-style headers and key-value fields:

```
Jul 10 09:08:47 PROMETHEUS/10.0.2.15 THOR: Alert: MODULE: SHIMCache SCANID: S-r4GhEhEiIRg MESSAGE: Malware name found in Shim Cache Entry ENTRY: C:\Users\neo\Desktop\ncat.exe KEYWORD: \\ncat\.exe
```

This repository provides syntax definitions that highlight:

- **Timestamps** — syslog format (`Jul 10 09:08:47`) and RFC3339 (`2024-03-20T08:22:00Z`)
- **Hostnames and IP addresses** — `PROMETHEUS/10.0.2.15`
- **Log levels** — color-coded: 🔴 `Alert` / `Error`, 🟠 `Warning`, 🔵 `Notice`, ⚪ `Info`
- **Field keys** — `MODULE:`, `MESSAGE:`, `SCORE:`, `REASON_1:`, `PARENT_FILE:`, etc.
- **Hashes** — MD5 (32 hex), SHA1 (40 hex), SHA256 (64 hex)
- **Scan IDs** — `S-r4GhEhEiIRg`
- **Numeric values** — scores, file sizes, ports

## Field Names

The field name list is derived from the [THOR JSON log definitions](https://github.com/NextronSystems/jsonlog) (`textlog` struct tags). This ensures comprehensive coverage of all fields THOR can produce, including:

- Numbered fields: `REASON_1`, `SUBSCORE_2`, `TAGS_1`
- Relation-prefixed fields: `PARENT_FILE`, `PARENT_MD5`
- Module-specific fields: `HIVEFILE`, `KEYWORD`, `FIRSTBYTES`, `LAUNCH_STRING`, etc.

## Log Format

THOR supports multiple output formats. This project targets the **text log format** (`.txt`), which is the default output and aligns with syslog message format.

For structured analysis, consider using the [JSON log format](https://github.com/NextronSystems/jsonlog) (`--jsonv2` or THOR 11+), which most editors already highlight natively as JSON.

## File Association

The syntax definitions auto-detect files by extension (`.thor.log`, `.thor.txt`) and by content (first-line matching). For files with generic names like `hostname_thor_2024-03-20.txt`, see each editor's README for manual association instructions.

## Sample Files

The `samples/` directory contains example log lines for testing and previewing the highlighting.

## Contributing

Contributions are welcome! If you'd like to add support for another editor (Notepad++, Emacs, JetBrains, etc.), please open a pull request.

## License

MIT
