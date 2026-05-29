#!/usr/bin/env bash

result=$(tmux list-sessions -F "#{session_name}" | fzf --reverse --print-query --prompt="Switch session > ")

[[ -z "$result" ]] && exit 0

selected=$(tail -1 <<< "$result")

if tmux has-session -t "$selected" 2>/dev/null; then
  tmux switch-client -t "$selected"
else
  tmux new-session -d -s "$selected" && tmux switch-client -t "$selected"
fi

