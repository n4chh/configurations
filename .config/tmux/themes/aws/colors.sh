#!/usr/bin/env bash

mode=$(defaults read -g AppleInterfaceStyle 2>/dev/null || echo Light)

BLUE=#3487ed
GREEN=#00802f
RED=#DB0000
WHITE=#ffffff

SOURCE=#ff9900
AWSPRIMARY=#232f3e
SECONDARY=#146eb4
TERCIARY=#faedca
if [[ $mode == "Dark" ]]; then
	PRIMARY=#f2f2f2
    TAGBG=#494949
    TAGFGDIM=#909090
    TAGFG=terminal
else
	PRIMARY=#232f3e
    TAGFG=terminal
    TAGFGDIM=#909090
    TAGBG=#d4d4d4
fi
if [[ "$1" == "set" ]]; then
    echo "hey2" >/tmp/test
fi
