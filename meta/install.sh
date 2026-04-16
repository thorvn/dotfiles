#!/bin/bash

set -e

DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"
cd "$DOTFILES"

echo "Starting dotfiles installation..."

# Check for Homebrew and install if not found
if ! command -v brew &>/dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    export NONINTERACTIVE=1
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    unset NONINTERACTIVE
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

# Run the software installation script
echo "Running software installation script..."
bash meta/software/mac_install.sh

# Symlink dotfiles via Makefile
echo "Symlinking dotfiles..."
make all

# Create local configuration files if they don't exist
touch "$HOME/.config/fish/config.local.fish"
touch "$HOME/.config/fish/alias.fish"

# Create .gitconfig.local if it doesn't exist
if [ ! -f "$HOME/.gitconfig.local" ]; then
    echo "Creating .gitconfig.local from template..."
    cp home/git/.gitconfig.local.template "$HOME/.gitconfig.local"
    echo "Please edit ~/.gitconfig.local to add your personal git information"
fi

fish meta/scripts/macos_config.fish

echo "Dotfiles installation complete!"
echo "Please restart your terminal or run 'source ~/.config/fish/config.fish' to apply the changes."
