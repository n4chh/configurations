#!/usr/bin/env bash

_utils_path="$HOME/.config/tmux/themes/utils.sh"
source $_utils_path
mode=$(detect_mode 2>&1)
BLUE=#3487ed
RED=#DB0000
WHITE=#ffffff

LEFT_ICON=""
RIGHT_ICON=""

BLACK="#1d1d1f"
WHITE="#FFFFFF"
MINTGREEN="#98FF98"
CORAL="#FF6F61"

GREEN=#73D216
YELLOW=#FCF8b3
RED="#D9534F"

GREY="#DDDAEC"
ACCENT="#6E56AF"
PRIMARY=$ACCENT
shopt -s nocasematch
if [[ $mode =~ dark ]]; then
	TAGBG="$BLACK"
    TAGFG="$GREY"
else
    TAGFG=terminal
    TAGBG="$GREY"
fi
shopt -u nocasematch
