#!/usr/bin/env bash

current_session="$1"
selected=$(tmux list-sessions -F "#{session_name}" | fzf --prompt="Select session: " \
    --header="Current: $current_session" \
    --preview="tmux list-windows -t {}" \
    --preview-window=right:60% \
    --bind="ctrl-n:execute(tmux new-session -d -s)+reload(tmux list-sessions -F \"#{session_name}\")" \
    --bind="ctrl-x:execute(tmux kill-session -t {})+reload(tmux list-sessions -F \"#{session_name}\")") 

if [[ -n "$selected" ]]; then
	tmux switch-client -t "$selected"
fi
