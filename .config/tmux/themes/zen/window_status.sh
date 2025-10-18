#!/usr/bin/env bash

cd $1
source colors.sh

tmux setw -g window-status-separator ''


function window_status() {
	# local TAB_BG="$TAG_BG"
	echo -n "#[fg=$TAB_BG]"
	echo -n "#{?window_start_flag,#[bg=terminal],#[bg=$TAB_BG]}"
	echo -n "#[range=window|#window_id]"
	echo -n "$LEFT_ICON"
	echo -n "#[fg=$TAG_FGDIM bg=$TAB_BG]"
	echo -n " "
	echo -n "#I"
	echo -n "#{?window_zoomed_flag, ,}"
	echo -n " #W#[norange]"
	echo -n " "
	echo -n "#[fg=$RED]#[range=user|kill#{window_id}]#[norange] "
	echo -n "#[fg=$TAB_BG]"
	echo -n "#{?window_end_flag,#[bg=terminal],#[bg=$TAB_BG]}"
	echo -n "$RIGHT_ICON"
	echo -n "#{?window_end_flag,#[fg=$SECONDARY range=user|new]#[norange] ,}"
}
function window_active_status() {
	# local ACTIVE_TAB_BG="$PRIMARY"
	# local TAB_BG="$TAG_BG"
	echo -n "#[fg=$ACTIVE_TAB_BG]"
	echo -n "#{?window_start_flag,#[bg=terminal],#[bg=$TAB_BG]}"
	echo -n "#[range=window|#window_id]"
	echo -n "$LEFT_ICON"
	echo -n "#[fg=$ACTIVE_TAB_FG bg=$ACTIVE_TAB_BG]"
	echo -n " "
	echo -n "#I"
	echo -n "#{?window_zoomed_flag, ,}"
	echo -n " #[bold]#W#[nobold norange]"
	echo -n " "
	echo -n "#[fg=$RED range=user|kill#{window_id}]#[norange] "
	echo -n "#[fg=$ACTIVE_TAB_BG]"
	echo -n "#{?window_end_flag,#[bg=terminal],#[bg=$TAB_BG]}"
	echo -n "$RIGHT_ICON"
	echo -n "#{?window_end_flag,#[fg=$SECONDARY range=user|new]#[norange] ,}"
}

if [[ $2 == "active" ]]; then
    echo "$(window_active_status)"
else
    echo "$(window_status)"
fi
