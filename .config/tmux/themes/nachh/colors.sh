#!/usr/bin/env bash

mode=$(gsettings get org.gnome.desktop.interface color-scheme)

BLUE=#3487ed
WHITE=#ffffff
BLACK=#000000

PRIMARY=#00ff99
SOURCE=#33ccff
SECONDARY=#537c8f
TERCIARY=#faedca
if [[ $mode == "'prefer-dark'" ]]; then
    TAGBG=#494949
    TAGFGDIM=#909090
    TAGFG=terminal
else
    TAGFG=terminal
    TAGFGDIM=#909090
    TAGBG=#eaeaea
fi
if [[ "$1" == "set" ]]; then
    echo "hey2" >/tmp/test
fi
