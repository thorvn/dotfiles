# Dotfiles

This repository contains my personal dotfiles and system configuration for macOS (with support for Linux). It's designed to provide a quick and easy setup for a new machine or to keep multiple machines in sync.
![Mac Screenshot](.mac-screenshot.png)

## Directory Structure

- `.software/`: Installation scripts for different platforms (macOS, Arch Linux, Ubuntu)
- `config/`: Core system configuration files (git, tmux, aerospace, etc.)
- `scripts/`: Utility scripts (backup, uninstall, macOS configuration)
- `fish/`: Fish shell configuration and functions
- `karabiner/`: Karabiner-Elements keyboard customization
- `lazygit/`: LazyGit TUI configuration
- `lazyvim/`: LazyVim (Neovim) configuration
- **Backup configs**: `alacritty/`, `astrovim/`, `cursor/`, `kitty/`, `skhd/`, `sketchybar/`, `wezterm/`, `yabai/`, `zellij/`, `zsh/`
- `install.sh`: Main installation script
- `store_password.sh`: Stores sudo password in macOS Keychain (optional)

## Installation

To install and set up the dotfiles, follow these steps:

1. Clone this repository:

   ```bash
   # Choose a location for the clone, e.g., ~/src
   git clone https://github.com/yourusername/dotfiles.git
   cd dotfiles # Or the directory name you cloned into
   # Optional: Prevent git from showing all untracked files in parent dirs
   git config --local status.showUntrackedFiles no
   ```

2. Authenticate `sudo` access:

   Before running the installation script, you need to authenticate `sudo`. This allows the script to install system-level tools (like Homebrew and its packages) without prompting you repeatedly for your password.

   ```bash
   sudo -v
   ```

   Enter your macOS login password when prompted. This will cache your `sudo` credentials for a short period.

3. Run the installation script:

   Now, run the main installer script:

   ```bash
   ./install.sh
   ```

This script will:

1. Check for Homebrew and install it non-interactively if missing
2. Install GNU Stow for managing symlinks
3. Run the platform-specific installation script (e.g., `mac_install.sh`) to install required software
4. Use GNU Stow to symlink active configuration files into your home directory (`~`)
5. Create local configuration files:
   - `~/.config/fish/config.local.fish` - Fish local config
   - `~/.config/fish/alias.fish` - Fish local aliases
   - `~/.gitconfig.local` - Git user info (from template)
6. Apply macOS system preferences (if on macOS)

## Idempotent Installation

The installation scripts are designed to be idempotent, meaning you can run them multiple times without causing issues. If a piece of software or a configuration is already in place, the scripts will skip it rather than reinstalling or overwriting.

## Components

### Active Tools & Configurations

**Shell & Terminal:**
- Fish Shell - User-friendly shell with smart completions
- Starship - Fast, minimal prompt for any shell
- Tmux - Terminal multiplexer

**Editor:**
- LazyVim (Neovim) - Highly extensible text editor with LazyVim distribution

**CLI Tools:**
- ripgrep - Fast recursive search
- eza - Modern `ls` replacement
- bat - `cat` with syntax highlighting
- fzf - Fuzzy finder
- zoxide - Smarter `cd` command
- lazygit - Terminal UI for git
- git-delta - Better git diffs with syntax highlighting
- pnpm - Fast package manager

**macOS Tools:**
- Karabiner-Elements - Keyboard customization
- Aerospace - Tiling window manager
- HiddenBar - Menu bar management
- Stats - System monitor

**Version Management:**
- mise - Universal tool version manager (replaces asdf)

### Backup Configurations

The following configs are kept for backup/reference but not auto-installed:
- Terminal emulators: Alacritty, Kitty, WezTerm, Ghostty
- Editors: AstroVim, Cursor
- Window managers: Yabai, SKHD, SketchyBar
- Multiplexers: Zellij
- Shells: Zsh configs

## Customization

### Local Configuration Files

These files are created automatically but not tracked by git:

- `~/.gitconfig.local` - Your personal git user info (name, email)
- `~/.config/fish/config.local.fish` - Machine-specific Fish configurations
- `~/.config/fish/alias.fish` - Personal Fish aliases

### Modifying Configurations

1. Edit files in the dotfiles directory (e.g., `~/.dotfiles/config/.gitconfig`)
2. Changes are immediately reflected since files are symlinked
3. Commit and push changes to sync across machines

### Stowing Additional Packages

To use a backup configuration (e.g., switching to Alacritty):

```bash
cd ~/.dotfiles
stow -vSt $HOME alacritty
```

To unstow a package:

```bash
stow -vDt $HOME alacritty
```

## Backup & Restore

### Backup Before Installation

```bash
./scripts/backup.sh
```

Creates a timestamped backup in `~/.dotfiles_backup_YYYYMMDD_HHMMSS/`

### Restore from Backup

```bash
# List available backups
ls -la ~/.dotfiles_backup_*

# Restore
cp -r ~/.dotfiles_backup_YYYYMMDD_HHMMSS/. ~/
```

### Uninstall

```bash
./scripts/uninstall.sh
```

Safely removes all stowed symlinks while preserving your local config files.

## Troubleshooting

**Stow conflicts:** If stow reports conflicts, backup and remove the conflicting files first:
```bash
mv ~/.gitconfig ~/.gitconfig.backup
```

**Fish not default shell:** Change manually:
```bash
chsh -s $(which fish)
```

**Permission issues:** Ensure scripts are executable:
```bash
chmod +x install.sh scripts/*.sh
```

## Platform-Specific Notes

### macOS
- Uses Homebrew for package management
- Includes Aerospace, Karabiner configurations
- Applies system preferences via `scripts/macos_config.fish`

### Linux
- Separate install scripts for Arch (`archlinux_install.sh`) and Ubuntu (`ubuntu_install.sh`)
- Screenshot available: `.arch_screenshot.png`

## Security Notes

- `store_password.sh` stores sudo password in Keychain - use with caution
- Personal git info moved to `~/.gitconfig.local` (not tracked)
- Sensitive files like SSH keys, tokens are gitignored

## Contributing

Feel free to:
- Fork this repository for your own use
- Open issues for bugs or questions
- Submit pull requests for improvements
