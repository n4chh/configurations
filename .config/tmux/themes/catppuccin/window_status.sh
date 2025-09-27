#!/usr/bin/env bash

cd $1
source colors.sh
tmux setw -g window-status-separator ""
function window_status() {
	echo -n "#[fg=$SURFACE0 #{?#{==:#{window_index},1},bg=terminal,bg=$SURFACE0}]"
	echo -n ""
	echo -n "#[fg=$SUBTEXT0 bg=$SURFACE0]"
	echo -n " "
	echo -n "#I"
	echo -n "#{?window_zoomed_flag, ,}"
	echo -n " #W"
	echo -n " "
	echo -n "#[fg=terminal bg=terminal]"
	echo -n "#[fg=$SURFACE0 #{?#{==:#{window_index},#{session_windows}},bg=terminal,bg=$SURFACE0}]"
	echo -n ""
}
function window_active_status() {
	echo -n "#[fg=$SURFACE2 #{?#{==:#{window_index},1},bg=terminal,bg=$SURFACE0}]"
	echo -n ""
	echo -n "#[fg=$TEXT bg=$SURFACE2]"
	echo -n " "
	echo -n "#I"
	echo -n "#{?window_zoomed_flag, ,}"
	echo -n " #[bold]#W#[nobold]"
	echo -n " "
	echo -n "#[fg=terminal bg=terminal]"
	echo -n "#[fg=$SURFACE2 #{?#{==:#{window_index},#{session_windows}},bg=terminal,bg=$SURFACE0}]"
	echo -n ""
}

if [[ $2 == "active" ]]; then
    echo "$(window_active_status)"
else
    echo "$(window_status)"
fi
