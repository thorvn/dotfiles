#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd "$(dirname "$0")/../.." && pwd)
tmp_dir=$(mktemp -d)
trap 'rm -rf "$tmp_dir"' EXIT

mock_bin=$tmp_dir/bin
log=$tmp_dir/commands.log
mkdir -p "$mock_bin"

printf '%s\n' '#!/usr/bin/env bash' 'printf '\''%s\n'\'' "sudo $*" >>"$MOCK_LOG"' \
  >"$mock_bin/sudo"
printf '%s\n' '#!/usr/bin/env bash' 'exit 0' >"$mock_bin/dnf"
chmod +x "$mock_bin/sudo" "$mock_bin/dnf"

MOCK_LOG="$log" PATH="$mock_bin:/usr/bin:/bin" DOTFILES_OS=Linux \
  bash "$repo_root/meta/configure-locale.sh"
grep -Fxq 'sudo localectl set-locale LANG=en_US.UTF-8' "$log"

: >"$log"
rm "$mock_bin/dnf"
printf '%s\n' '#!/usr/bin/env bash' 'exit 0' >"$mock_bin/apt-get"
chmod +x "$mock_bin/apt-get"
MOCK_LOG="$log" PATH="$mock_bin:/usr/bin:/bin" DOTFILES_OS=Linux \
  bash "$repo_root/meta/configure-locale.sh"
grep -Fxq 'sudo locale-gen en_US.UTF-8' "$log"
grep -Fxq 'sudo update-locale LANG=en_US.UTF-8 LC_ALL' "$log"

env -u LC_ALL LANG=en_US.UTF-8 DOTFILES_OS=Darwin \
  bash "$repo_root/meta/configure-locale.sh" >/dev/null
if LANG=C.UTF-8 LC_ALL=C.UTF-8 DOTFILES_OS=Darwin \
  bash "$repo_root/meta/configure-locale.sh" >/dev/null 2>&1; then
  printf '%s\n' 'expected invalid macOS locale to fail' >&2
  exit 1
fi

printf '%s\n' 'locale smoke: ok'
