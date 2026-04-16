#!/bin/bash
set -e

DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"
cd "$DOTFILES"

OS="$(uname)"

echo "Starting dotfiles installation..."

# ──────────────────────────────────────────────
# 1. Install dependencies
# ──────────────────────────────────────────────
if [ "$OS" = "Darwin" ]; then
    if ! command -v brew &>/dev/null; then
        echo "Installing Homebrew..."
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    eval "$(brew shellenv)"

    if ! command -v stow &>/dev/null; then
        brew install stow
    fi

    echo "Running macOS software installation..."
    bash meta/software/mac_install.sh
else
    # Detect distro and install
    if command -v dnf &>/dev/null; then
        echo "Running Fedora software installation..."
        bash meta/software/fedora_install.sh
    elif command -v apt-get &>/dev/null; then
        if ! command -v stow &>/dev/null; then
            sudo apt-get update -qq
            sudo apt-get install -y -qq stow make
        fi
        echo "Running Ubuntu software installation..."
        bash meta/software/ubuntu_install.sh
    else
        echo "Unsupported distro. Install dependencies manually, then run: make all"
        exit 1
    fi
fi

# ──────────────────────────────────────────────
# 2. Symlink dotfiles
# ──────────────────────────────────────────────
echo "Symlinking dotfiles..."
make all

# ──────────────────────────────────────────────
# 3. Post-stow setup
# ──────────────────────────────────────────────

# Create machine-specific fish config (gitignored)
touch "$HOME/.config/fish/config.local.fish"

# Create .gitconfig.local if it doesn't exist
if [ ! -f "$HOME/.gitconfig.local" ]; then
    echo "Creating .gitconfig.local from template..."
    cp home/git/.gitconfig.local.template "$HOME/.gitconfig.local"
    echo "Please edit ~/.gitconfig.local to add your personal git information"
fi

# macOS-specific setup
if [ "$OS" = "Darwin" ] && command -v fish &>/dev/null; then
    fish meta/scripts/macos_config.fish
fi

echo "Dotfiles installation complete!"
echo "Restart your terminal or run 'source ~/.config/fish/config.fish' to apply changes."
