#!/usr/bin/env bash
source ./colors.sh

function vpn_status() {
    local vpn_status=$(ifconfig | grep -A 1 POINTOPOINT | grep 'inet ' | awk '{print $2}')
    if [ -z "$vpn_status" ]; then
        echo " #[fg=$BLUE]#[fg=colour255 bg=$BLUE] #[fg=$TAGFGDIM bg=$TAGBG] Disconnected#[fg=$TAGBG bg=terminal] "
    else
        echo " #[fg=$BLUE]#[fg=colour255 bg=$BLUE] #[fg=terminal bg=$TAGBG] $vpn_status#[fg=$TAGBG bg=terminal] "
    fi
}

date=$(date +"%D %T")
vpn=$(vpn_status)

echo -n "$vpn#[bg=terminal fg=$PRIMARY]$date"
