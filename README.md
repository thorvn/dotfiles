# Dotfiles

This repository contains my personal dotfiles and system configuration for macOS. It's designed to provide a quick and easy setup for a new machine or to keep multiple machines in sync.
![Mac_Iterm2](.mac-iterm2.png)

## Directory Structure

- `.software/`: Contains installation scripts for software and tools.
- `config/`: Contains configuration files for various tools and applications.
- `install.sh`: Main installation script to set up the dotfiles and required software.
- `store_password.sh`: Script to securely store the sudo password in the macOS Keychain.

## Installation

To install and set up the dotfiles, follow these steps:

1. Clone this repository to your home directory:

   ```
   git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
   cd .dotfiles
   git config --local status.showUntrackedFiles no
   ```

2. Navigate to the dotfiles directory:

   ```
   cd ~/.dotfiles
   ```

3. Run the installation script:
   ```
   ./install.sh
   ```

This script will:

1. Install Homebrew if it's not already installed.
2. Install GNU Stow for managing symlinks.
3. Prompt you to store your sudo password securely in the macOS Keychain.
4. Run the mac_install.sh script to install required software.
5. Use GNU Stow to symlink the configuration files to their appropriate locations.

## Secure Password Storage

To avoid frequent password prompts during installation and updates, this dotfiles setup includes a feature to securely store your sudo password in the macOS Keychain. Here's how it works:

1. The `store_password.sh` script prompts you for your sudo password.
2. It stores the password securely in the macOS Keychain under the name "SudoPassword".
3. The installation scripts retrieve the password from the Keychain when needed, eliminating the need for manual password entry.

This feature ensures that your password is stored securely and is only accessible by your user account. If you need to update or remove the stored password, you can use the Keychain Access application and look for the "SudoPassword" item under the "login" keychain.

## Idempotent Installation

The installation scripts are designed to be idempotent, meaning you can run them multiple times without causing issues. If a piece of software or a configuration is already in place, the scripts will skip it rather than reinstalling or overwriting.

## Components

This dotfiles setup includes configurations and installations for:

- Fish Shell: A user-friendly command line shell with enhanced history management.
- Neovim: A highly extensible text editor.
- Tmux: A terminal multiplexer for managing multiple terminal sessions.
- Starship: A minimal, fast, and customizable prompt for any shell.
- FZF: A command-line fuzzy finder.
- Zoxide: A smarter cd command.
- Various CLI tools: ripgrep, eza, bat, git-delta, lazygit, etc.
- HiddenBar: A menu bar icon manager for macOS.

### Enhanced History Management

The Fish shell configuration includes an advanced history cleaning function that:

- Removes common commands that clutter the history (e.g., cd, ls, clear).
- Automatically deletes potentially sensitive commands (e.g., those containing passwords, API keys, or accessing sensitive files).
- Limits the history size to prevent it from growing too large.

This feature helps maintain a clean and secure command history.

## Customization

You can customize the dotfiles by modifying the configuration files in the `config/` directory. After making changes, run `./install.sh` again to update the symlinks.

Key files for customization:

- `config/.config/fish/config.fish`: Main Fish shell configuration.
- `config/.config/fish/alias.fish`: Custom aliases (create this file if it doesn't exist).
- `config/.config/fish/config.local.fish`: Machine-specific configurations (create this file if it doesn't exist).

## Note

Make sure to review the scripts and configurations before installing to ensure they meet your needs. You may want to fork this repository and customize it for your personal use.

## Feedback and Contributions

Feel free to open an issue or submit a pull request if you have any suggestions or improvements!
