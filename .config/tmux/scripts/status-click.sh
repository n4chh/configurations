#!/usr/bin/env bash

mouse_status_range="$1"
window_id="$2"
case "$mouse_status_range" in
	window)
		tmux select-window -t "$window_id"
	;;
	kill*)
		tmux kill-window -t "${mouse_status_range#kill}"
	;;
	new)
		tmux new-window
	;;
	*)
		echo "[$(date)] - mouse_status_range: $mouse_status_range window_id: $window_id" >> ~/.local/share/tmux/scripts.log
	;;
esac
status=$?
if [[ $status -ne 0 ]]; then
	msg="Check logs at \e[1m~/.local/share/tmux"
	tmux display-popup -T "Error code: $status" -x P -y P -h 4 -w 40 -EE "echo -en '$msg' ; sleep 1.5"
	echo "[$(date)] - mouse_status_range: $mouse_status_range window_id: $window_id" >> ~/.local/share/tmux/scripts.log
fi

echo "mouse_status_range: $mouse_status_range window_id: $window_id" > ~/.local/share/tmux/scripts.log
