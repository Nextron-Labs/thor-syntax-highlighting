# THOR Log — Vim / Neovim

Syntax highlighting for [THOR APT Scanner](https://www.nextron-systems.com/thor/) text log files.

## Installation

### Using a Plugin Manager (Recommended)

#### vim-plug

```vim
Plug 'Nextron-Labs/thor-syntax-highlighting', { 'rtp': 'vim' }
```

#### lazy.nvim (Neovim)

```lua
{
  "Nextron-Labs/thor-syntax-highlighting",
  config = function()
    vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/lazy/thor-syntax-highlighting/vim")
  end,
}
```

#### Vundle

```vim
Plugin 'Nextron-Labs/thor-syntax-highlighting', { 'rtp': 'vim' }
```

### Manual Installation

Copy the files to your Vim runtime directory:

```bash
# Vim
mkdir -p ~/.vim/syntax ~/.vim/ftdetect
cp vim/syntax/thorlog.vim ~/.vim/syntax/
cp vim/ftdetect/thorlog.vim ~/.vim/ftdetect/

# Neovim
mkdir -p ~/.config/nvim/syntax ~/.config/nvim/ftdetect
cp vim/syntax/thorlog.vim ~/.config/nvim/syntax/
cp vim/ftdetect/thorlog.vim ~/.config/nvim/ftdetect/
```

### File Association

The filetype detection automatically activates for:

- Files with extensions `.thor.log` or `.thor.txt`
- Any `.log` or `.txt` file whose first few lines contain `THOR:` or `THOR_UTIL:` followed by a log level

To force the syntax on any file:

```vim
:set filetype=thorlog
```

## What Gets Highlighted

| Element | Highlight Group | Default Color |
|---------|----------------|---------------|
| Timestamps | `thorTimestamp` → `Number` | Magenta/Yellow |
| Hostnames | `thorHost` → `Identifier` | Cyan |
| Hostname/IP | `thorHost` + `thorHostIP` → `Constant` | Cyan + Red/Magenta |
| Source (`THOR:`) | `thorSource` → `Keyword` | Yellow |
| Alert | `thorLevelAlert` | 🔴 Red (bold) |
| Error | `thorLevelError` | 🟣 Purple |
| Warning | `thorLevelWarning` | 🟡 Yellow |
| Notice | `thorLevelNotice` | 🔵 Blue |
| Info | `thorLevelInfo` | 🟢 Green |
| Field keys | `thorFieldKey` → `Type` | Green |
| Hashes | `thorHash*` → `Special` | Magenta |
| IP addresses | `thorIPAddress` → `Constant` | Red/Magenta |
| Scan IDs | `thorScanID` → `Constant` | Red/Magenta |
| Numbers | `thorNumber` → `Number` | Magenta/Yellow |

Colors adapt to your colorscheme. The syntax uses standard Vim highlight groups with explicit fallback colors for log levels.
