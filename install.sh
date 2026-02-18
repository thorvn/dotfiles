#!/bin/bash

set -e

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
bash .software/mac_install.sh

# Use stow to symlink dotfiles
echo "Symlinking dotfiles..."
stow -vSt $HOME config
stow -vSt $HOME fish

# Stow active tool configurations
# Add/remove packages below based on what you're currently using
stow -vSt $HOME karabiner
stow -vSt $HOME lazygit
stow -vSt $HOME lazyvim

# Other packages available for manual stowing when needed:
# stow -vSt $HOME alacritty
# stow -vSt $HOME astrovim
# stow -vSt $HOME kitty
# stow -vSt $HOME skhd
# stow -vSt $HOME sketchybar
# stow -vSt $HOME wezterm
# stow -vSt $HOME yabai
# stow -vSt $HOME zellij
# stow -vSt $HOME zsh

# Create local configuration files if they don't exist
touch $HOME/.config/fish/config.local.fish
touch $HOME/.config/fish/alias.fish

# Create .gitconfig.local if it doesn't exist
if [ ! -f $HOME/.gitconfig.local ]; then
    echo "Creating .gitconfig.local from template..."
    cp config/.gitconfig.local.template $HOME/.gitconfig.local
    echo "Please edit ~/.gitconfig.local to add your personal git information"
fi

fish scripts/macos_config.fish

# Hide local config from git (run with fish since ghide is a fish alias)
fish -c "ghide fish/.config/fish/config.local.fish"

echo "Dotfiles installation complete!"
echo "Please restart your terminal or run 'source ~/.config/fish/config.fish' to apply the changes."
echo ""
echo "Note: Your sudo password has been securely stored in the macOS Keychain."
echo "If you need to update or remove it, you can use the Keychain Access application."
echo "Look for an item named 'SudoPassword' under the 'login' keychain."
