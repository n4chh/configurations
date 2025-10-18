#!/usr/bin/env bash

mode=$(gsettings get org.gnome.desktop.interface.color-scheme)


BLUE=#3487ed
WHITE=#ffffff

SOURCE=#3487ed
PRIMARY=#f2c078
SECONDARY=#84b7f3
TERCIARY=#faedca
if [[ $mode == "'prefer-dark'" ]]; then
    TAGBG=#494949
    TAGFGDIM=#909090
    TAGFG=terminal
else
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
