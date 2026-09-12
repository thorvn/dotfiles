#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
OS=${DOTFILES_OS:-$(uname)}

install_platform_software() {
  if [[ $OS == Darwin ]]; then
    if ! command -v brew &>/dev/null; then
      echo "Installing Homebrew..."
      NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    eval "$(brew shellenv)"

    if ! command -v stow &>/dev/null; then
      brew install stow
    fi

    echo "Running macOS software installation..."
    bash "$DOTFILES/meta/software/mac_install.sh"
  elif command -v dnf &>/dev/null; then
    echo "Running Fedora software installation..."
    bash "$DOTFILES/meta/software/fedora_install.sh"
  elif command -v apt-get &>/dev/null; then
    if ! command -v stow &>/dev/null; then
      sudo apt-get update -qq
      sudo apt-get install -y -qq stow make
    fi
    echo "Running Ubuntu software installation..."
    bash "$DOTFILES/meta/software/ubuntu_install.sh"
  else
    echo "Unsupported distro. Install dependencies manually, then run: make all" >&2
    return 1
  fi
}

zsh_path() {
  if [[ $OS == Darwin ]]; then
    [[ -x /bin/zsh ]] || {
      echo "The macOS system Zsh was not found at /bin/zsh." >&2
      return 1
    }
    printf '%s\n' /bin/zsh
  else
    command -v zsh || {
      echo "Zsh was not installed by the platform package manager." >&2
      return 1
    }
  fi
}

stow_dotfiles() {
  echo "Symlinking dotfiles..."
  make -C "$DOTFILES" all
}

provision_zsh_plugins() {
  bash "$DOTFILES/meta/install-antidote.sh"
}

configure_login_locale() {
  bash "$DOTFILES/meta/configure-locale.sh"
}

smoke_test_zsh() {
  local shell_path=$1
  local smoke_stderr smoke_status=0
  smoke_stderr=$(mktemp "${TMPDIR:-/tmp}/dotfiles-zsh-smoke.XXXXXX")

  "$shell_path" -i -c \
    '[[ $ZDOTDIR == ${XDG_CONFIG_HOME:-$HOME/.config}/zsh && -r $ZDOTDIR/.zshrc && ${ZSH_PLUGIN_STACK_READY:-0} == 1 ]]' \
    </dev/null >/dev/null 2>"$smoke_stderr" || smoke_status=$?

  if (( smoke_status != 0 )) || [[ -s $smoke_stderr ]]; then
    if [[ -s $smoke_stderr ]]; then
      cat -- "$smoke_stderr" >&2
    fi
    rm -f -- "$smoke_stderr"
    return 1
  fi

  rm -f -- "$smoke_stderr"
}

verify_zsh_binary() {
  local shell_path=$1
  "$shell_path" -f -c 'exit 0'
}

current_login_shell() {
  if [[ $OS == Darwin ]]; then
    dscl . -read "/Users/$USER" UserShell 2>/dev/null | awk '{print $2}'
  else
    local account
    account=$(getent passwd "$USER") || return 1
    printf '%s\n' "${account##*:}"
  fi
}

set_default_zsh() {
  local shell_path=$1 current_shell=''

  current_shell=$(current_login_shell 2>/dev/null) || true
  if [[ $current_shell == "$shell_path" ]]; then
    echo "Zsh is already the login shell."
    return 0
  fi

  if ! grep -Fxq "$shell_path" /etc/shells; then
    echo "Refusing to set an unregistered login shell: $shell_path" >&2
    return 1
  fi

  echo "Setting Zsh as the default shell..."
  chsh -s "$shell_path"
}

activate_zsh() {
  local shell_path
  shell_path=$(zsh_path) || return

  verify_zsh_binary "$shell_path" || {
    echo "Zsh failed its minimal startup check; the login shell was not changed." >&2
    return 1
  }
  set_default_zsh "$shell_path" || return

  stow_dotfiles || {
    echo "Dotfile linking failed after Zsh was selected as the login shell." >&2
    return 1
  }
  provision_zsh_plugins || {
    echo "Zsh plugin provisioning failed after Zsh was selected as the login shell." >&2
    return 1
  }
  smoke_test_zsh "$shell_path" || {
    echo "Zsh startup smoke test failed after Zsh was selected as the login shell." >&2
    return 1
  }
}

post_stow_setup() {
  if [[ ! -f $HOME/.gitconfig.local ]]; then
    echo "Creating .gitconfig.local from template..."
    cp "$DOTFILES/home/git/.gitconfig.local.template" "$HOME/.gitconfig.local"
    echo "Please edit ~/.gitconfig.local to add your personal git information"
  fi

  if [[ $OS == Darwin ]]; then
    bash "$DOTFILES/meta/scripts/macos_config.sh"
  fi
}

main() {
  cd "$DOTFILES"
  echo "Starting dotfiles installation..."

  install_platform_software
  configure_login_locale
  activate_zsh
  post_stow_setup

  echo "Dotfiles installation complete!"
  echo "Restart your terminal to start Zsh."
  echo "Start a new login session before checking the configured locale in a new tmux server."
}

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
  main "$@"
fi
