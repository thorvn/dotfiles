#!/bin/bash

set -e

echo "Starting dotfiles installation..."

# Check for Homebrew and install if not found
if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew already installed. Skipping..."
fi

# Ensure Homebrew is in the PATH
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install GNU Stow
if ! command -v stow &>/dev/null; then
    echo "Installing GNU Stow..."
    brew install stow
else
    echo "GNU Stow already installed. Skipping..."
fi

# Store sudo password in Keychain
echo "We need to store your sudo password in the macOS Keychain for seamless installation."
echo "This will allow the installation script to run sudo commands without prompting for a password each time."
echo "Your password will be securely stored in the Keychain and can only be accessed by your user account."
bash store_password.sh

# Run the software installation script
echo "Running software installation script..."
bash .software/mac_install.sh

# Use stow to symlink dotfiles
echo "Symlinking dotfiles..."
stow $HOME config
stow $HOME fish
stow $HOME wezterm

# Create local configuration files if they don't exist
touch $HOME/.config/fish/config.local.fish
touch $HOME/.config/fish/alias.fish


ghide fish/.config/fish/config.local.fish

echo "Dotfiles installation complete!"
echo "Please restart your terminal or run 'source ~/.config/fish/config.fish' to apply the changes."
echo ""
echo "Note: Your sudo password has been securely stored in the macOS Keychain."
echo "If you need to update or remove it, you can use the Keychain Access application."
echo "Look for an item named 'SudoPassword' under the 'login' keychain."
