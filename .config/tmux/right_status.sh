#!/usr/bin/env bash
source ./colors.sh

function vpn_status() {
    local vpn_status=$(ifconfig | grep -A 1 POINTOPOINT | grep 'inet ' | awk '{print $2}')
    if [ -z "$vpn_status" ]; then
        echo " #[fg=$PRIMARY]#[fg=$PRIMARYFG bg=$PRIMARY] #[fg=$TAGFGDIM bg=$TAGBG] Disconnected#[fg=$TAGBG bg=terminal] "
    else
        echo " #[fg=$PRIMARY]#[fg=$PRIMARYFG bg=$PRIMARY] #[fg=terminal bg=$TAGBG] $vpn_status#[fg=$TAGBG bg=terminal] "
    fi
}

date=$(date +"%D %T")
vpn=$(vpn_status)

echo -n "$vpn#[bg=terminal fg=$PRIMARY]$date"
