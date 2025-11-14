#!/usr/bin/env bash
cd $1

#!/usr/bin/env bash
cd $1
source colors.sh

function vpn_status() {
    local vpn_status=$(ifconfig | grep -A 1 POINTOPOINT | grep 'inet ' | awk '{print $2}')
    if [ "$vpn_status" ]; then
		# echo -n " "
		echo -n "#[fg=$TAG_BG]"
		echo -n "$LEFT_ICON"
		echo -n "#[fg=$PRIMARY bg=$TAG_BG]"
		echo -n " "
		echo -n "#[fg=$TAG_FG bold]$vpn_status"
		echo -n "#[nobold fg=$TAG_BG bg=terminal]"
		echo -n "$RIGHT_ICON"
    fi
}

date=$(date +"%D %T")
vpn=$(vpn_status)

# echo -n " #[fg=$SURFACE0]"

# echo -n "#[fg=$PRIMARY bg=$TAG_BG]"
# echo -n "$RIGHT_ICON"
echo -n "#[fg=$PRIMARY]#W #[fg=terminal]at #[fg=$TAG_FG bold]#S "
echo -n "$vpn"
echo -n " "
echo -n "#[fg=$PRIMARY]"
echo -n "$date"

