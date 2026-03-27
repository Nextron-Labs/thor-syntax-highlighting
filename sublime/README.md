# THOR Log — Sublime Text

Syntax highlighting for [THOR APT Scanner](https://www.nextron-systems.com/thor/) text log files.

## Installation

### Via Package Control (Recommended)

> *Coming soon* — once this package is registered with Package Control.

### Manual Installation

1. Open Sublime Text
2. Go to **Preferences → Browse Packages…**
3. Create a folder called `THOR Log` inside the `Packages` directory
4. Copy `THOR Log.sublime-syntax` into that folder

To update after changes:
- Simply replace the `THOR Log.sublime-syntax` file in your `Packages/THOR Log/` directory
- Sublime Text will reload the syntax automatically

### File Association

The syntax auto-detects files with the extensions `.thor.log` and `.thor.txt`, and files whose first line matches the THOR log format.

For other files, select the syntax manually:

- **View → Syntax → THOR Log**

Or add a project-specific association in your `.sublime-project`:

```json
{
  "settings": {
    "syntax": "Packages/THOR Log/THOR Log.sublime-syntax"
  }
}
```

## What Gets Highlighted

| Element | Example |
|---------|---------|
| Timestamps | `Jul 10 09:08:47`, `2024-03-20T08:22:00Z` |
| Hostnames / IPs | `PROMETHEUS/10.0.2.15` |
| Source | `THOR:`, `THOR_UTIL:` |
| Log levels | `Alert`, `Warning`, `Notice`, `Info`, `Error` |
| Field keys | `MODULE:`, `MESSAGE:`, `REASON_1:`, `PARENT_FILE:` |
| Hashes | MD5, SHA1, SHA256 |
| IP addresses | `185.141.25.168` |
| Scan IDs | `S-r4GhEhEiIRg` |
| Numeric values | Scores, sizes, ports |
