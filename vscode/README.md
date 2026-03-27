# THOR Log — Visual Studio Code

Syntax highlighting for [THOR APT Scanner](https://www.nextron-systems.com/thor/) text log files.

## Installation

### Via VS Code Marketplace (Recommended)

> *Coming soon* — once this extension is published to the Marketplace.

### Manual Installation (VSIX)

1. Package the extension:

   ```bash
   cd vscode
   npx @vscode/vsce package
   ```

2. Install the `.vsix` file:

   ```bash
   code --install-extension thor-log-1.0.0.vsix
   ```

To update after changes, rebuild and reinstall:
```bash
cd vscode && npx @vscode/vsce package && code --install-extension thor-log-1.0.0.vsix
```

### Manual Installation (Copy)

1. Copy the entire `vscode/` directory to your VS Code extensions folder:

   - **Linux:** `~/.vscode/extensions/nextron.thor-log-1.0.0/`
   - **macOS:** `~/.vscode/extensions/nextron.thor-log-1.0.0/`
   - **Windows:** `%USERPROFILE%\.vscode\extensions\nextron.thor-log-1.0.0\`

2. Restart VS Code

### File Association

The extension auto-detects files with the extensions `.thor.log` and `.thor.txt`.

For other files, add a file association in your `settings.json`:

```json
{
  "files.associations": {
    "*_thor_*.txt": "thorlog",
    "*_thor_*.log": "thorlog"
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
