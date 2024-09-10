#!/bin/bash

set -e

echo "Starting dotfiles installation..."

# Check for Homebrew and install if not found
if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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

# Run the software installation script
echo "Running software installation script..."
bash .software/mac_install.sh

# Use stow to symlink dotfiles
echo "Symlinking dotfiles..."
stow -v -R -t $HOME config

# Create local configuration files if they don't exist
touch $HOME/.config/fish/config.local.fish
touch $HOME/.config/fish/alias.fish

echo "Dotfiles installation complete!"
echo "Please restart your terminal or run 'source ~/.config/fish/config.fish' to apply the changes."
