#!/usr/bin/env bash
set -euo pipefail

readonly ANTIDOTE_VERSION=v2.1.0
readonly ANTIDOTE_REVISION=4913257e0ae3fee2a77e7189e526fe55b6ff9536
readonly ANTIDOTE_REPOSITORY=https://github.com/mattmc3/antidote.git

repo_root=$(cd "$(dirname "$0")/.." && pwd)
data_home=${XDG_DATA_HOME:-$HOME/.local/share}
cache_home=${XDG_CACHE_HOME:-$HOME/.cache}
antidote_dir=$data_home/antidote
plugin_home=$cache_home/antidote
plugin_manifest=$repo_root/config/zsh/.zsh_plugins.txt
plugin_static=$plugin_home/zsh_plugins.zsh

if ! zsh_bin=$(command -v zsh); then
  printf 'Antidote setup requires Zsh.\n' >&2
  exit 1
fi

mkdir -p "${antidote_dir%/*}" "$plugin_home"

if [[ -e $antidote_dir && ! -d $antidote_dir/.git ]]; then
  printf 'Refusing to replace non-Git path: %s\n' "$antidote_dir" >&2
  exit 1
fi

if [[ ! -d $antidote_dir/.git ]]; then
  git clone --quiet --depth 1 --branch "$ANTIDOTE_VERSION" \
    "$ANTIDOTE_REPOSITORY" "$antidote_dir"
else
  antidote_origin=$(git -C "$antidote_dir" remote get-url origin)
  case $antidote_origin in
    "$ANTIDOTE_REPOSITORY"|https://github.com/getantidote/antidote.git|git@github.com:mattmc3/antidote.git|git@github.com:getantidote/antidote.git)
      ;;
    *)
      printf 'Refusing to update unexpected Antidote origin: %s\n' "$antidote_origin" >&2
      exit 1
      ;;
  esac
fi

if ! git -C "$antidote_dir" cat-file -e "$ANTIDOTE_REVISION^{commit}" 2>/dev/null; then
  git -C "$antidote_dir" fetch --quiet --depth 1 origin "$ANTIDOTE_REVISION"
fi
git -C "$antidote_dir" checkout --quiet --detach "$ANTIDOTE_REVISION"

installed_revision=$(git -C "$antidote_dir" rev-parse HEAD)
if [[ $installed_revision != "$ANTIDOTE_REVISION" ]]; then
  printf 'Antidote revision mismatch: expected %s, got %s\n' \
    "$ANTIDOTE_REVISION" "$installed_revision" >&2
  exit 1
fi

plugin_tmp=$(mktemp "$plugin_home/.zsh_plugins.zsh.XXXXXX")
trap 'rm -f "$plugin_tmp"' EXIT

ANTIDOTE_HOME="$plugin_home" "$zsh_bin" -f -c '
  source "$1"
  antidote bundle < "$2" > "$3"
' zsh "$antidote_dir/antidote.zsh" "$plugin_manifest" "$plugin_tmp"

mv -f "$plugin_tmp" "$plugin_static"
trap - EXIT
printf 'Installed Antidote %s and generated %s\n' \
  "$ANTIDOTE_VERSION" "$plugin_static"
