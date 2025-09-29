#!/usr/bin/env bash

cd $1
source colors.sh

tmux setw -g window-status-separator ''


function window_status() {
	echo -n "#[range=window|#window_id]#[fg=$TAGBG #{?window_start_flag,bg=terminal,bg=$TAGBG}]"
	echo -n ""
	echo -n "#[fg=$TAGFGDIM bg=$TAGBG]"
	echo -n " "
	echo -n "#I"
	echo -n "#{?window_zoomed_flag, ,}"
	echo -n " #W#[norange] "
	echo -n "#[fg=$RED]#[range=user|kill#{window_id}]#[norange fg=$TAGFGDIM] "
	echo -n "#[fg=terminal bg=terminal]"
	echo -n "#[fg=$TAGBG #{?window_end_flag,bg=terminal,bg=$TAGBG}]"
	echo -n ""
	echo -n "#{?window_end_flag,#[fg=$PRIMARY range=user|new]#[norange] ,}"
}
function window_active_status() {
	echo -n "#[range=window|#window_id]#[fg=$PRIMARY #{?window_start_flag,bg=terminal,bg=$TAGBG}]"
	echo -n ""
	echo -n "#[fg=$SOURCE bg=$PRIMARY]"
	echo -n " "
	echo -n "#I"
	echo -n "#{?window_zoomed_flag, ,}"
	echo -n " #[bold]#W#[nobold norange] "
	echo -n "#[fg=$RED range=user|kill#{window_id}]#[norange fg=$TAGFGDIM] "
	echo -n "#[fg=terminal bg=terminal]"
	echo -n "#[fg=$PRIMARY #{?window_end_flag,bg=terminal,bg=$TAGBG}]"
	echo -n ""
	echo -n "#{?window_end_flag,#[fg=$PRIMARY range=user|new]#[norange] ,}"
}

if [[ $2 == "active" ]]; then
    echo "$(window_active_status)"
	# echo "#{E:window-status-format}"
else
    echo "$(window_status)"
	# echo '#I:#W#{?window_flags,#{window_flags}, }#[range=user|kill#{window_id}](X)#[norange]'
fi
