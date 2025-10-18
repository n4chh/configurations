#!/usr/bin/env bash

cd $1
source colors.sh

tmux setw -g window-status-separator ''

# LEFT_ICON=""
# RIGHT_ICON=""

function window_status() {
	local tab_bg=$TAGBG
	echo -n "#[range=window|#window_id]"
	echo -n "#[fg=$tab_bg]#{?window_start_flag,#[bg=terminal],#[bg=$tab_bg]}"
	echo -n "$LEFT_ICON"
	echo -n "#[fg=$TAGFGDIM bg=$tab_bg]"
	echo -n " "
	echo -n "#I"
	echo -n "#{?window_zoomed_flag, ,}"
	echo -n " #W#[norange]"
	echo -n " "
	echo -n "#[fg=$RED]#[range=user|kill#{window_id}]#[norange] "
	echo -n "#[fg=$tab_bg]#{?window_end_flag,#[bg=terminal],#[bg=$tab_bg]}"
	echo -n "$RIGHT_ICON"
	echo -n "#{?window_end_flag,#[fg=$PRIMARY range=user|new]#[norange] ,}"
}
function window_active_status() {
	local active_tab_bg=$PRIMARY
	local tab_bg=$TAGBG
	echo -n "#[range=window|#window_id]"
	echo -n "#[fg=$active_tab_bg]#{?window_start_flag,#[bg=terminal],#[bg=$tab_bg]}"
	echo -n "$LEFT_ICON"
	echo -n "#[fg=$TAGFG bg=$active_tab_bg]"
	echo -n " "
	echo -n "#I"
	echo -n "#{?window_zoomed_flag, ,}"
	echo -n " #[bold]#W#[nobold norange]"
	echo -n " "
	echo -n "#[fg=$RED range=user|kill#{window_id}]#[norange] "
	echo -n "#[fg=$active_tab_bg]#{?window_end_flag,#[bg=terminal],#[bg=$tab_bg]}"
	echo -n "$RIGHT_ICON"
	echo -n "#{?window_end_flag,#[fg=$PRIMARY range=user|new]#[norange] ,}"
}

if [[ $2 == "active" ]]; then
    echo "$(window_active_status)"
else
    echo "$(window_status)"
fi
