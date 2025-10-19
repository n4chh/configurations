#!/usr/bin/env bash
cd $1
source colors.sh
# LEFT_ICON=""
# RIGHT_ICON=""

function vpn_status() {
    local vpn_status=$(ip a | grep -A 2 POINTOPOINT | grep 'inet ' | awk '{print $2}')
	local tag_bg=$TAGBG
	if [[ $mode == "'prefer-dark'" ]]; then
		tag_bg="$CANONICAL_AUBERIGNE"
	else
		tag_bg="$CANONICAL_AUBERIGNE80"
	fi
    if [ "$vpn_status" ]; then
		
		# echo -n "#[fg=$TEXT bg=$SURFACE0]"
		# echo -n " "
		# echo -n "#[fg=$SUBTEXT0 bg=$SURFACE0] Disconnected"
    # else
		echo -n " "
		echo -n "#[fg=$tag_bg ]"
		echo -n "$LEFT_ICON"
		echo -n "#[fg=$WARM_GREY bg=$tag_bg]"
		echo -n " "
		echo -n "#[fg=$WHITE bold] $vpn_status"
		echo -n "#[nobold fg=$tag_bg bg=$TAGBG]"
		echo -n "$RIGHT_ICON"
    fi
}

date=$(date +"%D %T")
vpn=$(vpn_status)

# echo -n " #[fg=$SURFACE0]"

echo -n "$vpn"
# echo -n " "
# echo -n "#[fg=$TAGBG]$LEFT_ICON"
echo -n "#[fg=terminal bg=$TAGBG] "
echo -n "$date"
echo -n " "
