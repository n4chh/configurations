#!/usr/bin/env bash

cd $1
source colors.sh

tmux setw -g window-status-separator ''

function get_index_format() {
	local i=("󰎡 " "󰬺 " "󰬻 " "󰬼 " "󰬽 " "󰬾 " "󰬿 " "󰭀 " "󰭁 " "󰭂 ")
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
	echo -n "#[fg=$TAB_BG]"
	echo -n "#{?window_start_flag,#[bg=$TAG_BG],#[bg=$RED]}"
	echo -n "#[range=window|#window_id]"
	# echo -n "$LEFT_ICON"
	# echo -n "$LEFT_ICON"
	echo -n "#[fg=$TAG_FGDIM bg=$TAB_BG]"
	echo -n " "
	echo -n "$(get_index_format)"
	echo -n "#{?window_zoomed_flag, ,}"
	echo -n "#W#[norange]"
	echo -n " "
	echo -n "#[range=user|kill#{window_id}]"
	echo -n "#[fg=$WHITE bg=$RED] #[norange] #[bg=$TAB_BG]"
	echo -n "#{?window_end_flag,"
	echo -n "#[range=user|new]"
	echo -n "#[fg=$ACTIVE_TAB_FG bg=$PRIMARY] 󱇬"
	echo -n "#[norange] #[fg=$PRIMARY bg=terminal],}"
}
function window_active_status() {
	echo -n "#[fg=$ACTIVE_TAB_BG]"
	echo -n "#[range=window|#window_id]"
	echo -n "#[fg=$ACTIVE_TAB_FG bg=$ACTIVE_TAB_BG]"
	echo -n " "
	echo -n "$(get_index_format)"
	echo -n "#{?window_zoomed_flag, ,}"
	echo -n "#[bold]#W#[nobold norange]"
	echo -n " "
	echo -n "#[range=user|kill#{window_id}]"
	echo -n "#[fg=$WHITE bg=$RED] #[norange] #[bg=$TAB_BG]"
	echo -n "#{?window_end_flag,"
	echo -n "#[range=user|new]"
	echo -n "#[fg=$ACTIVE_TAB_FG bg=$PRIMARY] 󱇬"
	echo -n "#[norange] #[fg=$PRIMARY bg=terminal],}"
}

if [[ $2 == "active" ]]; then
    echo "$(window_active_status)"
else
    echo "$(window_status)"
fi
