#!/bin/bash

# Exit on error
set -e

# Function to get sudo password from Keychain
get_sudo_password() {
    security find-generic-password -a "$USER" -s "SudoPassword" -w 2>/dev/null
}

# Function to run command with sudo using stored password
run_sudo() {
    local password=$(get_sudo_password)
    if [ -z "$password" ]; then
        echo "Sudo password not found in Keychain. Please run store_password.sh first."
        exit 1
    fi
    echo "$password" | sudo -S "$@"
}

echo "Checking fish shell..."
if ! command -v fish &> /dev/null; then
    echo "Installing fish shell..."
    brew install fish
    if [ "$SHELL" != "$(which fish)" ]; then
        echo "Changing default shell to fish..."
        run_sudo bash -c "echo $(which fish) >> /etc/shells"
        run_sudo chsh -s $(which fish) $USER
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
    "git-delta"
    "lazygit"
    "stow"
    "tmux"
    "stats"
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

echo "Checking mise..."
if ! command -v mise &> /dev/null; then
    echo "Installing mise..."
    curl https://mise.run | sh
fi

echo "Checking font..."
if ! brew list --cask font-iosevka-term-nerd-font &>/dev/null; then
    echo "Installing font..."
    brew install --cask font-iosevka-term-nerd-font
else
    echo "Font is already installed. Skipping."
fi

echo "Software installation complete!"
