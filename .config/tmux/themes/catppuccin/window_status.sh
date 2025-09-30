#!/usr/bin/env bash

cd $1
source colors.sh
tmux setw -g window-status-separator ""
LEFT_ICON=""
RIGHT_ICON=""
function window_status() {
	local tab_bg=$SURFACE0
	echo -n "#[fg=$tab_bg #{?#{==:#{window_index},1},bg=terminal,bg=$tab_bg}]"
	echo -n "$LEFT_ICON"
	echo -n "#[fg=$SUBTEXT0 bg=$tab_bg]"
	echo -n " "
	echo -n "#I"
	echo -n "#{?window_zoomed_flag, ,}"
	echo -n " #W"
	echo -n " "
	echo -n "#[fg=$RED]#[range=user|kill#{window_id}]#[norange fg=$TAGFGDIM] "
	echo -n "#[fg=terminal bg=terminal]"
	echo -n "#[range=window|#window_id]#[fg=$tag_bg #{?window_start_flag,bg=terminal,bg=$tag_bg}]"
	echo -n "#[fg=$tab_bg #{?window_end_flag,bg=terminal,bg=$tab_bg}]"
	echo -n "$RIGHT_ICON"
	echo -n "#{?window_end_flag,#[fg=$GREEN range=user|new]#[norange] ,}"
}
function window_active_status() {
	local active_tag_bg=$SURFACE2
	local tab_bg=$SURFACE0
	echo -n "#[fg=$active_tag_bg #{?#{==:#{window_index},1},bg=terminal,bg=$tab_bg}]"
	echo -n "$LEFT_ICON"
	echo -n "#[fg=$TEXT bg=$active_tag_bg]"
	echo -n " "
	echo -n "#I"
	echo -n "#{?window_zoomed_flag, ,}"
	echo -n " #[bold]#W#[nobold]"
	echo -n " "
	echo -n "#[fg=$RED range=user|kill#{window_id}]#[norange] "
	echo -n "#[fg=terminal bg=terminal]"
	echo -n "#[fg=$active_tag_bg #{?window_end_flag,bg=terminal,bg=$tab_bg}]"
	echo -n "$RIGHT_ICON"
	echo -n "#{?window_end_flag,#[fg=$GREEN range=user|new]#[norange] ,}"
}

if [[ $2 == "active" ]]; then
    echo "$(window_active_status)"
else
    echo "$(window_status)"
fi
