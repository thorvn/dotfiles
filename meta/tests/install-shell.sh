#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd "$(dirname "$0")/../.." && pwd)
# shellcheck source=../install.sh
source "$repo_root/meta/install.sh"

tmp_dir=$(mktemp -d)
trap 'rm -rf "$tmp_dir"' EXIT

run_case() {
  local failure=${1:-none}
  local log=$tmp_dir/$failure.log
  : >"$log"

  zsh_path() { printf '%s\n' /mock/zsh; }
  stow_dotfiles() {
    printf '%s\n' stow >>"$log"
    [[ $failure != stow ]]
  }
  provision_zsh_plugins() {
    printf '%s\n' provision >>"$log"
    [[ $failure != provision ]]
  }
  smoke_test_zsh() {
    [[ $1 == /mock/zsh ]]
    printf '%s\n' smoke >>"$log"
    [[ $failure != smoke ]]
  }
  set_default_zsh() {
    [[ $1 == /mock/zsh ]]
    printf '%s\n' chsh >>"$log"
  }

  if [[ $failure == none ]]; then
    activate_zsh
    [[ $(paste -sd, "$log") == stow,provision,smoke,chsh ]]
  else
    if activate_zsh 2>/dev/null; then
      printf 'expected activation failure at %s\n' "$failure" >&2
      return 1
    fi
    if grep -Fxq chsh "$log"; then
      printf 'login shell changed after %s failure\n' "$failure" >&2
      return 1
    fi
  fi
}

run_case none
run_case stow
run_case provision
run_case smoke

printf '%s\n' 'install shell cutover smoke: ok'
