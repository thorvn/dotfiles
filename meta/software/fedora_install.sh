#!/bin/bash
set -e

echo "Installing Fedora packages..."

# Core tools available in Fedora repos
sudo dnf install -y \
  fish \
  neovim \
  fzf \
  ripgrep \
  bat \
  tmux \
  stow \
  make \
  curl \
  eza \
  zoxide \
  git-delta \

  # util-linux-user

# starship
if ! command -v starship &>/dev/null; then
  echo "Installing starship..."
  sudo dnf copr enable atim/starship
  sudo dnf install starship
fi

# tera
sudo dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
sudo dnf install zed

sudo dnf copr enable scottames/ghostty
sudo dnf install ghostty

sudo dnf copr enable jdxcode/mise
sudo dnf install mise



# lazygit

# mise (version manager)
# if ! command -v mise &>/dev/null; then
#   echo "Installing mise..."
#   curl https://mise.run | sh
# fi

# direnv
# if ! command -v direnv &>/dev/null; then
#   sudo dnf install -y direnv
# fi

# Nerd font
# FONT_DIR="$HOME/.local/share/fonts"
# if ! fc-list | grep -qi "iosevka.*nerd"; then
#   echo "Installing Iosevka Term Nerd Font..."
#   mkdir -p "$FONT_DIR"
#   FONT_VERSION=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | grep tag_name | cut -d '"' -f4)
#   curl -fsSL "https://github.com/ryanoasis/nerd-fonts/releases/download/${FONT_VERSION}/IosevkaTerm.tar.xz" -o /tmp/IosevkaTerm.tar.xz
#   tar -xf /tmp/IosevkaTerm.tar.xz -C "$FONT_DIR"
#   fc-cache -f
#   rm /tmp/IosevkaTerm.tar.xz
# fi

# Set fish as default shell
if [ "$SHELL" != "$(which fish)" ]; then
  echo "Setting fish as default shell..."
  sudo chsh -s "$(which fish)" "$USER"
fi

# Tmux plugin manager
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  echo "Installing tmux plugin manager..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "Fedora software installation complete!"
