#!/bin/sh
# tmux per-pane Claude cache countdown. Arg $1: tmux pane id (e.g. %3).
# Reads ~/.claude/.cache-ts-<pane> written by the Claude Code hooks (keyed by TMUX_PANE).
# Each pane runs its own Claude session, so each border shows that session's own timer.

p=$(printf '%s' "$1" | tr -d '%')
[ -n "$p" ] || exit 0
f="$HOME/.claude/.cache-ts-$p"
[ -f "$f" ] || exit 0
last=$(cat "$f" 2>/dev/null)
[ -n "$last" ] || exit 0

now=$(date +%s)
[ $((now - last)) -gt 3600 ] && exit 0           # idle > 1h -> hide

remaining=$((last + 300 - now))
if [ "$remaining" -le 0 ]; then
  printf '#[fg=#f38ba8]CACHE EXPIRED'
else
  mm=$((remaining / 60)); ss=$((remaining % 60))
  if   [ "$remaining" -le 60 ];  then c='#f38ba8'   # red:    < 1m left
  elif [ "$remaining" -le 120 ]; then c='#f9e2af'   # yellow: < 2m left
  else                                c='#a6e3a1'   # green:  healthy
  fi
  printf '#[fg=%s]CACHE IN: %d:%02d' "$c" "$mm" "$ss"
fi
