#!/usr/bin/env bash
set -euo pipefail

TARGET_LOCALE=en_US.UTF-8
OS=${DOTFILES_OS:-$(uname)}

validate_macos_locale() {
  local invalid=0

  if [[ ${LANG:-} != "$TARGET_LOCALE" ]]; then
    printf 'macOS login locale must set LANG=%s (found %s).\n' \
      "$TARGET_LOCALE" "${LANG:-unset}" >&2
    invalid=1
  fi

  if [[ ${LC_ALL+x} == x ]]; then
    printf 'macOS login locale must leave LC_ALL unset.\n' >&2
    invalid=1
  fi

  if (( invalid )); then
    printf '%s\n' \
      'Update macOS Language & Region and terminal locale settings, start a new login session, then rerun the installer.' >&2
    return 1
  fi

  printf 'macOS login locale is %s with LC_ALL unset.\n' "$TARGET_LOCALE"
}

configure_ubuntu_locale() {
  printf 'Configuring Ubuntu locale as %s...\n' "$TARGET_LOCALE"
  sudo locale-gen "$TARGET_LOCALE"
  # A variable without a value removes it from the persistent locale file.
  sudo update-locale LANG="$TARGET_LOCALE" LC_ALL
}

configure_fedora_locale() {
  printf 'Configuring Fedora locale as %s...\n' "$TARGET_LOCALE"
  # localectl writes the complete system locale, so only LANG is persisted.
  sudo localectl set-locale LANG="$TARGET_LOCALE"
}

main() {
  if [[ $OS == Darwin ]]; then
    validate_macos_locale
  elif command -v dnf &>/dev/null; then
    configure_fedora_locale
  elif command -v apt-get &>/dev/null; then
    configure_ubuntu_locale
  else
    printf '%s\n' 'Unsupported platform for locale configuration.' >&2
    return 1
  fi
}

if [[ ${BASH_SOURCE[0]} == "$0" ]]; then
  main "$@"
fi
