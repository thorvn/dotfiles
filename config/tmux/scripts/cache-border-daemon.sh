#!/bin/sh
# Live per-pane Claude cache countdown in tmux pane borders.
# tmux's #() in pane-border-format does NOT reliably refresh per-pane (tmux#1852),
# so we resolve each pane's countdown here and set its border explicitly, once/second.
# Self-dedupes via a pidfile; exits when the tmux server goes away.

PIDFILE="$HOME/.claude/.cache-border-daemon.pid"
if [ -f "$PIDFILE" ] && kill -0 "$(cat "$PIDFILE" 2>/dev/null)" 2>/dev/null; then
  exit 0                                   # already running
fi
echo $$ > "$PIDFILE"
trap 'rm -f "$PIDFILE"' EXIT

SELF="$HOME/.config/tmux/scripts/cache-pane.sh"
PATHFMT='#[fg=#6c7086] #{b:pane_current_path} '   # tmux expands this per-pane (works fine)

while tmux has-session 2>/dev/null; do
  for pane in $(tmux list-panes -a -F '#{pane_id}'); do
    seg=$("$SELF" "$pane")                 # resolved text, e.g. "#[fg=#a6e3a1]cache 3:30"
    if [ -n "$seg" ]; then
      tmux set-option -p -t "$pane" pane-border-format "$PATHFMT $seg "
    else
      tmux set-option -pu -t "$pane" pane-border-format 2>/dev/null  # fall back to global
    fi
  done
  sleep 1
done
