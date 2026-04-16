#!/bin/bash
set -e

DOTFILES="$HOME/.dotfiles"
REPO="https://github.com/thorvn/dotfiles.git"

# ──────────────────────────────────────────────
# 1. Install git + stow + make
# ──────────────────────────────────────────────
install_deps() {
  if [ "$(uname)" = "Darwin" ]; then
    if ! command -v brew &>/dev/null; then
      echo "Installing Homebrew..."
      NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      eval "$(brew shellenv)"
    fi
    brew install git stow
  elif command -v dnf &>/dev/null; then
    sudo dnf install -y -q git stow make
  elif command -v apt-get &>/dev/null; then
    sudo apt-get update -qq
    sudo apt-get install -y -qq git stow make
  else
    echo "Unsupported package manager. Install git, stow, and make manually."
    exit 1
  fi
}

# ──────────────────────────────────────────────
# 2. Clone the repo (HTTPS, no SSH key needed)
# ──────────────────────────────────────────────
clone_repo() {
  if [ -d "$DOTFILES" ]; then
    echo "$DOTFILES already exists, pulling latest..."
    git -C "$DOTFILES" pull
  else
    echo "Cloning dotfiles..."
    git clone "$REPO" "$DOTFILES"
  fi
}

# ──────────────────────────────────────────────
# 3. Clone and run full install
# ──────────────────────────────────────────────
install_deps
clone_repo
cd "$DOTFILES"
bash meta/install.sh

echo ""
echo "Done. You can switch the remote to SSH later:"
echo "  cd ~/.dotfiles && git remote set-url origin git@github.com:thorvn/dotfiles.git"
