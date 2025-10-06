#!/usr/bin/env bash
cd $1
source colors.sh

function vpn_status() {
    local vpn_status=$(ifconfig | grep -A 1 POINTOPOINT | grep 'inet ' | awk '{print $2}')
    if [ -z "$vpn_status" ]; then
        echo " #[fg=$SOURCE]#[fg=$TAGFG bg=$SOURCE] #[fg=$TAGFGDIM bg=$TAGBG] Disconnected#[fg=$TAGBG bg=terminal] "
    else
        echo " #[fg=$SOURCE]#[fg=$TAGFG bg=$SOURCE] #[fg=$TAGFG bg=$TAGBG] $vpn_status#[fg=$TAGBG bg=terminal] "
    fi
}

date=$(date +"%D %T")
vpn=$(vpn_status)

echo -n "$vpn#[bg=terminal fg=$SOURCE]$date"
