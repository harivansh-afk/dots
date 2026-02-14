#!/bin/sh
current=$(tmux display-message -p '#S')
tmux list-sessions -F '#S' | while IFS= read -r s; do
  if [ "$s" = "$current" ]; then
    printf '#[bg=#4F4946,fg=#d8a657] %s #[bg=default,fg=default]' "$s"
  else
    printf ' %s ' "$s"
  fi
done
