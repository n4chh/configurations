#!/usr/bin/env bash
cd $1
source colors.sh
# LEFT_ICON=""
# RIGHT_ICON=""

function vpn_status() {
    local vpn_status=$(ifconfig | grep -A 1 POINTOPOINT | grep 'inet ' | awk '{print $2}')
    if [ "$vpn_status" ]; then
		
		# echo -n "#[fg=$TEXT bg=$SURFACE0]"
		# echo -n " "
		# echo -n "#[fg=$SUBTEXT0 bg=$SURFACE0] Disconnected"
    # else
		echo -n " "
		echo -n "#[fg=$TAGBG ]"
		echo -n "$LEFT_ICON"
		echo -n "#[fg=$PRIMARY bg=$TAGBG]"
		echo -n " "
		echo -n "#[fg=$GREEN bold] $vpn_status"
		echo -n "#[nobold fg=$TAGBG bg=terminal]"
		echo -n "$RIGHT_ICON"
    fi
}

date=$(date +"%D %T")
vpn=$(vpn_status)

echo -n "$vpn"
echo -n " "
echo -n "#[fg=$PRIMARY]"
echo -n "$date"
