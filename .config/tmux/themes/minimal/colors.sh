#!/usr/bin/env bash

mode=$(defaults read -g AppleInterfaceStyle 2>/dev/null || echo Light)

BLUE=#3487ed
RED=#DB0000
WHITE=#ffffff

LEFT_ICON=""
RIGHT_ICON=""

BLACK="#1d1d1f"
WHITE="#FFFFFF"
GREY="#f5f5f7"
ACCENT="#0066cc"
MINTGREEN="#98FF98"
CORAL="#FF6F61"

GREEN=#34C759
YELLOW=#FAC800
RED="#FF5C5F"

AWSPRIMARY=#232f3e
SECONDARY=#146eb4
TERCIARY=#faedca
PRIMARY=$ACCENT
if [[ $mode == "Dark" ]]; then
	TAGBG="#2c2c2d"
    TAGFG=terminal
else
	PRIM_CONTRAST=#f2f2f2
    TAGFG=terminal
    TAGBG=$GREY
fi
if [[ "$1" == "set" ]]; then
    echo "hey2" >/tmp/test
fi
