#!/bin/bash

# Exit on error
set -e

echo "Checking fish shell..."
if ! command -v fish &> /dev/null; then
    echo "Installing fish shell..."
    brew install fish
    if [ "$SHELL" != "$(which fish)" ]; then
        echo "Changing default shell to fish..."
        chsh -s $(which fish)
    fi
else
    echo "Fish shell is already installed. Skipping."
fi

echo "Checking CLI tools..."
cli_tools=(
    "nvim"
    "starship"
    "fzf"
    "zoxide"
    "neovim"
    "ripgrep"
    "eza"
    "bat"
    "mysql-client@8.4"
    "pnpm"
    "asdf"
    "protobuf"
    "git-delta"
    "lazygit"
    "stow"
    "tmux"
)

for tool in "${cli_tools[@]}"; do
    if brew list "$tool" &>/dev/null; then
        echo "$tool is already installed. Skipping."
    else
        echo "Installing $tool..."
        brew install "$tool"
    fi
done

echo "Checking GUI applications..."
if brew list --cask hiddenbar &>/dev/null; then
    echo "HiddenBar is already installed. Skipping."
else
    echo "Installing HiddenBar..."
    brew install --cask hiddenbar
fi

echo "Checking tmux plugin manager..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "Installing tmux plugin manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
    echo "Tmux plugin manager is already installed. Skipping."
fi

echo "Software installation complete!"
