#!/usr/bin/env bash

cd $1
source colors.sh

tmux setw -g window-status-separator ""

LEFT_ICON=""
RIGHT_ICON=""

function get_index_format() {
	local i=("󰎡 " "󰎤 " "󰎧 " "󰎪 " "󰎭 " "󰎱 " "󰎳 " "󰎶 " "󰎹 " "󰎼 ")
	echo -n "#{?#{==:#I,0},${i[0]},}"
	echo -n "#{?#{==:#I,1},${i[1]},}"
	echo -n "#{?#{==:#I,2},${i[2]},}"
	echo -n "#{?#{==:#I,3},${i[3]},}"
	echo -n "#{?#{==:#I,4},${i[4]},}"
	echo -n "#{?#{==:#I,5},${i[5]},}"
	echo -n "#{?#{==:#I,6},${i[6]},}"
	echo -n "#{?#{==:#I,7},${i[7]},}"
	echo -n "#{?#{==:#I,8},${i[8]},}"
	echo -n "#{?#{==:#I,9},${i[9]},}"
}

function window_status() {
	local tab_bg=$SURFACE0
	echo -n "#[range=window|#window_id]"
	echo -n "#[fg=$tab_bg]#{?window_start_flag,#[bg=terminal],#[bg=$tab_bg]}"
	echo -n "$LEFT_ICON"
	echo -n "#[fg=$SUBTEXT0 bg=$tab_bg]"
	echo -n " "
	echo -n "$(getfindex_format)"
	echo -n "#{?window_zoomed_flag, ,}"
	echo -n "#W#[norange]"
	echo -n " "
	echo -n "#[fg=$RED]#[range=user|kill#{window_id}]#[norange fg=$TAGFGDIM] "
	echo -n "#[fg=$tab_bg]#{?window_end_flag,#[bg=terminal],#[bg=$tab_bg]}"
	echo -n "$RIGHT_ICON"
	echo -n "#{?window_end_flag,#[fg=$GREEN range=user|new]#[norange] ,}"
}
function window_active_status() {
	local active_tab_bg=$SURFACE2
	local tab_bg=$SURFACE0
	echo -n "#[fg=$active_tab_bg]"
	echo -n "#{?window_start_flag,#[bg=terminal],#[bg=$tab_bg]}"
	echo -n "$LEFT_ICON"
	echo -n "#[fg=$TEXT bg=$active_tab_bg]"
	echo -n " "
	echo -n "$(get_index_format)"
	echo -n "#{?window_zoomed_flag, ,}"
	echo -n "#[bold]#W#[nobold norange]"
	echo -n " "
	echo -n "#[fg=$RED range=user|kill#{window_id}]#[norange] "
	echo -n "#[fg=$active_tab_bg]#{?window_end_flag,#[bg=terminal],#[bg=$tab_bg]}"
	echo -n "$RIGHT_ICON"
	echo -n "#{?window_end_flag,#[fg=$GREEN range=user|new]#[norange] ,}"
}

if [[ $2 == "active" ]]; then
    echo "$(window_active_status)"
else
    echo "$(window_status)"
fi
