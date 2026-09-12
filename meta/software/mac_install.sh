#!/bin/bash

# Exit on error
set -e

echo "Installing CLI tools..."
brew install starship fzf zoxide neovim ripgrep eza bat git-delta lazygit stow tmux stats

echo "Installing GUI applications and fonts..."
brew install --cask hiddenbar font-iosevka-term-nerd-font

echo "Checking tmux plugin manager..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing tmux plugin manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "Tmux plugin manager is already installed. Skipping."
fi

echo "Checking mise..."
if ! command -v mise &> /dev/null; then
    echo "Installing mise..."
    curl https://mise.run | sh
fi

echo "Software installation complete!"
