#!/bin/bash
set -e

echo "Installing Ubuntu packages..."
sudo apt-get -y install curl zsh git neovim fzf eza ripgrep bat tmux stow make build-essential xclip git-delta locales

# mise
if ! command -v mise &>/dev/null; then
  echo "Installing mise..."
  curl https://mise.run | sh
  mise install bun@latest
  mise use -g bun
  mise install node@lts
  mise use -g node
  # mise install go@latest
  # mise use -g go
fi

# starship
if ! command -v starship &>/dev/null; then
  echo "Installing starship..."
  curl -sS https://starship.rs/install.sh | sh
fi

# zoxide
if ! command -v zoxide &>/dev/null; then
  echo "Installing zoxide..."
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

# git-delta
if ! command -v delta &>/dev/null; then
  echo "Installing git-delta..."
  DELTA_VERSION=$(curl -s https://api.github.com/repos/dandavison/delta/releases/latest | grep tag_name | cut -d '"' -f4)
  curl -sS "https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_amd64.deb" -o /tmp/git-delta.deb
  sudo dpkg -i /tmp/git-delta.deb
fi

echo "Ubuntu software installation complete!"
