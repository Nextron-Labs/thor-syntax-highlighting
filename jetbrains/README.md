# THOR Log — JetBrains IDEs

Syntax highlighting for [THOR APT Scanner](https://www.nextron-systems.com/thor/) text log files.

Works with **all JetBrains IDEs**: IntelliJ IDEA, PyCharm, WebStorm, GoLand, CLion, PhpStorm, Rider, RustRover, etc.

## Installation

### Via TextMate Bundle Import (Recommended)

JetBrains IDEs natively support TextMate bundles:

1. Open your IDE
2. Go to **Settings** → **Editor** → **TextMate Bundles**
3. Click **+** (Add)
4. Navigate to this repository and select the `jetbrains/thor-log.tmbundle` directory
5. Click **OK**

The syntax is immediately available for `.thor.log` and `.thor.txt` files.

To update after changes:
- Remove the bundle from **Settings** → **Editor** → **TextMate Bundles**
- Re-add it from the updated repository

### Manual File Copy

1. Locate your IDE's configuration directory:

   - **Linux:** `~/.config/JetBrains/<Product><Version>/textmate/`
   - **macOS:** `~/Library/Application Support/JetBrains/<Product><Version>/textmate/`
   - **Windows:** `%APPDATA%\JetBrains\<Product><Version>\textmate\`

   Where `<Product>` is e.g. `IntelliJIdea`, `PyCharm`, `WebStorm`, etc.

2. Copy the bundle:

   ```bash
   cp -r jetbrains/thor-log.tmbundle ~/.config/JetBrains/<Product><Version>/textmate/
   ```

3. Restart the IDE

### File Association

The syntax auto-detects files with extensions `.thor.log` and `.thor.txt`, and files whose first line matches the THOR log format.

For other file patterns, add a custom association:

1. Go to **Settings** → **Editor** → **File Types**
2. Find **THOR Log** in the list
3. Add patterns like `*_thor_*.txt` or `*_thor_*.log`

Or right-click a file in the Project view → **Associate with File Type…** → **THOR Log**

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

## Color Scheme

Colors follow the TextMate scope conventions used by your IDE's color scheme. The scopes map naturally to most themes:

| Scope | Typical Color |
|-------|---------------|
| `constant.numeric.timestamp` | Purple/Magenta |
| `entity.name.hostname` | Cyan |
| `keyword.other.source` | Yellow/Orange |
| `markup.error` (Alert/Error) | Red |
| `markup.warning` (Warning) | Orange/Yellow |
| `markup.info` (Notice) | Blue/Green |
| `comment` (Info) | Gray |
| `entity.name.tag.field-key` | Green |
| `constant.other.hash` | Purple |
| `constant.numeric.ip-address` | Red/Magenta |
