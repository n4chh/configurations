#!/usr/bin/env bash
cd $1
source colors.sh
LEFT_ICON=""
# RIGHT_ICON=""
RIGHT_ICON="#[bg=$SURFACE2 fg=terminal] "

function vpn_status() {
    local vpn_status=$(ifconfig | grep -A 1 POINTOPOINT | grep 'inet ' | awk '{print $2}')
    if [ "$vpn_status" ]; then
		
		# echo -n "#[fg=$TEXT bg=$SURFACE0]"
		# echo -n " "
		# echo -n "#[fg=$SUBTEXT0 bg=$SURFACE0] Disconnected"
    # else
		echo -n " #[fg=$SURFACE0]$LEFT_ICON"
		echo -n "#[fg=$BLUE bg=$SURFACE0]"
		echo -n " "
		echo -n "#[fg=$TEAL bg=$SURFACE0 bold] $vpn_status#[nobold]"
    fi
}

date=$(date +"%D %T")
vpn=$(vpn_status)

# echo -n " #[fg=$SURFACE0]"

echo -n "$vpn"
echo -n " #[fg=$SURFACE2]$LEFT_ICON#[bg=$SURFACE2]"
echo -n "#[fg=$TEXT]"
echo -n "$date"
echo -n "#[fg=$SURFACE2 bg=terminal]$RIGHT_ICON"
