#!/usr/bin/env bash
set -euo pipefail

repo_root=$(cd "$(dirname "$0")/../.." && pwd)
zsh_bin=${ZSH_BIN:-$(command -v zsh)}
test_root=$(mktemp -d)
trap 'rm -rf "$test_root"' EXIT

fail() {
  printf 'not ok - %s\n' "$1" >&2
  exit 1
}

pass() {
  printf 'ok - %s\n' "$1"
}

prepare_home() {
  local home=$1
  mkdir -p "$home/.config"
  stow -R -d "$repo_root/home" -t "$home" zsh >/dev/null
  stow -R --no-folding -d "$repo_root" -t "$home/.config" config >/dev/null
}

home=$test_root/static-home
prepare_home "$home"

static_env=$(env -i HOME="$home" PATH=/usr/bin:/bin \
  "$zsh_bin" -c 'print -r -- "$XDG_CONFIG_HOME|$ZDOTDIR|$EDITOR|$VISUAL|$PATH"')
expected_prefix="$home/.config|$home/.config/zsh|nvim|nvim|"
[[ $static_env == "$expected_prefix"* ]] || fail 'non-interactive startup exports static environment'
[[ :${static_env##*|}: == *":$home/.local/bin:"* ]] || fail 'non-interactive startup exports user paths'
pass 'non-interactive startup exports static environment and user paths'

interactive_home=$test_root/interactive-home
prepare_home "$interactive_home"

interactive_stdout=$test_root/interactive.stdout
interactive_stderr=$test_root/interactive.stderr
env -i HOME="$interactive_home" PATH=/usr/bin:/bin TERM=xterm \
  "$zsh_bin" -i -c \
  'print -r -- "${aliases[g]-missing}|${aliases[ls]-missing}|${aliases[greset]-missing}|${aliases[cd]-missing}|${options[AUTO_CD]}|${options[AUTO_PUSHD]}"' \
  >"$interactive_stdout" 2>"$interactive_stderr"
[[ $(<"$interactive_stdout") == 'git|eza --icons|missing|missing|off|off' ]] || \
  fail 'interactive startup loads curated aliases and explicit directory behavior'
[[ $(wc -l <"$interactive_stderr") -eq 1 ]] || fail 'missing plugin artifacts emit one concise warning'
grep -Fq 'plugins unavailable' "$interactive_stderr" || fail 'missing plugin artifacts identify the degraded behavior'
pass 'interactive startup remains usable without plugin artifacts'

[[ -s $interactive_home/.cache/zsh/.zcompdump ]] || \
  fail 'completion dump is stored in the XDG cache'
[[ ! -e $interactive_home/.config/zsh/.zcompdump ]] || \
  fail 'global compinit does not write a completion dump beside tracked config'

env -i HOME="$interactive_home" PATH=/usr/bin:/bin TERM=dumb \
  "$zsh_bin" -c 'zsh -i -c exit' >/dev/null 2>/dev/null
[[ ! -e $interactive_home/.config/zsh/.zcompdump ]] || \
  fail 'nested Zsh inherits the global compinit opt-out'
pass 'completion cache stays outside the stowed config tree'

printf '%s\n' 'typeset -g LOCAL_CONFIG_LOADED=yes' >"$interactive_home/.config/zsh/local.zsh"
local_loaded=$(env -i HOME="$interactive_home" PATH=/usr/bin:/bin TERM=dumb \
  "$zsh_bin" -i -c 'print -r -- ${LOCAL_CONFIG_LOADED:-no}' 2>/dev/null)
[[ $local_loaded == yes ]] || fail 'interactive startup loads optional local configuration'
pass 'aliases and optional local configuration load successfully'

history_home=$test_root/history-home
prepare_home "$history_home"
printf '%s\n' "alias disposable=':'" "alias reusable='print -r --'" \
  >"$history_home/.config/zsh/local.zsh"

printf '%s\n' \
  'gss' \
  'pwd' \
  'disposable' \
  'reusable with-argument' \
  'print -r -- adjacent-duplicate' \
  'print -r -- adjacent-duplicate' \
  'print -r -- meaningful-recurrence' \
  'print -r -- separator' \
  'print -r -- meaningful-recurrence' \
  ' print -r -- leading-space-kept' \
  'history 1' \
  'exit' | \
  env -i HOME="$history_home" PATH=/usr/bin:/bin TERM=dumb \
    "$zsh_bin" -i >/dev/null 2>/dev/null

history_file=$history_home/.local/state/zsh/history
[[ -s $history_file ]] || fail 'interactive commands persist promptly to XDG state history'
grep -Eq '^: [0-9]+:[0-9]+;reusable with-argument$' "$history_file" || \
  fail 'alias invocations with arguments remain reusable'
grep -Eq '^: [0-9]+:[0-9]+; print -r -- leading-space-kept$' "$history_file" || \
  fail 'leading spaces do not suppress history'
[[ $(grep -Ec ';print -r -- adjacent-duplicate$' "$history_file") -eq 1 ]] || \
  fail 'adjacent duplicate commands are suppressed'
[[ $(grep -Ec ';print -r -- meaningful-recurrence$' "$history_file") -eq 2 ]] || \
  fail 'non-adjacent command recurrence is preserved'
if grep -Eq ';(gss|pwd|disposable|history 1)$' "$history_file"; then
  fail 'standalone noise, aliases, and history management commands are excluded'
fi
pass 'history persists reusable commands and filters low-value commands'
