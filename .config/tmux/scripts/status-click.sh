#!/usr/bin/env bash

mouse_status_range="$1"
window_id="$2"
case "$mouse_status_range" in
	window)
		tmux select-window -t $window_id
	;;
	kill*)
		tmux kill-window -t "${mouse_status_range#kill}"
	;;
	new)
		tmux new-window
	;;
	*)
		echo "mouse_status_range: $mouse_status_range window_id: $window_id" > ~/.local/share/tmux/scripts.log
	;;
esac

echo "mouse_status_range: $mouse_status_range window_id: $window_id" > ~/.local/share/tmux/scripts.log
