#!/usr/bin/env bash

mode=$(defaults read -g AppleInterfaceStyle 2>/dev/null || echo Light)

BLUE=#3487ed
WHITE=#ffffff

PRIMARY=#c1fb33
SECONDARY=#c1dbb3
TERCIARY=#faedca
if [[ $mode == "Dark" ]]; then
	SOURCE=#c1fbb3
	SOURCE=#c1fb33
    TAGBG=#494949
    TAGFGDIM=#909090
    TAGFG=terminal
else
	SOURCE=#218b53
    TAGFG=terminal
    TAGFGDIM=#909090
    TAGBG=#d4d4d4
fi
if [[ "$1" == "set" ]]; then
    echo "hey2" >/tmp/test
    tmux set-option -g pane-border-style 'fg=terminal'
    tmux set-option -g pane-active-border-style "fg=$SOURCE"
    tmux set-option -g status-style "bg=terminal fg=$SOURCE"
fi
