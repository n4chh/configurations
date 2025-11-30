#!/usr/bin/env bash

mode=$(defaults read -g AppleInterfaceStyle 2>/dev/null || echo Light)

BLUE=#3487ed
RED=#DB0000
WHITE=#ffffff

LEFT_ICON=""
RIGHT_ICON=""

BLACK="#1d1d1f"
WHITE="#FFFFFF"
GREY="#DDDAEC"
ACCENT="#6E56AF"
MINTGREEN="#98FF98"
CORAL="#FF6F61"

GREEN=#73D216
YELLOW=#FCF8b3
RED="#D9534F"

AWSPRIMARY=#232f3e
SECONDARY=#146eb4
TERCIARY=#faedca
PRIMARY=$ACCENT
if [[ $mode == "Dark" ]]; then
	TAGBG="#2c2c2d"
	PRIM_CONTRAST=#DDDFFF
    TAGFG=terminal
else
	PRIM_CONTRAST=#DDDFFF
    TAGFG=terminal
    TAGBG=$GREY
fi
if [[ "$1" == "set" ]]; then
    echo "hey2" >/tmp/test
fi
