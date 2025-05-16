#!/usr/bin/env bash

source ./colors.sh
function window_status() {
    echo "#[fg=$SECONDARY]#[bg=$SECONDARY fg=$SECONDARYBG]  #[fg=$SECONDARY bg=$SECONDARYBG] #I #W #[fg=$SECONDARYBG bg=terminal]"
}

function window_active_status() {
    echo "#[fg=$PRIMARY]#[bg=$PRIMARY fg=$PRIMARYFG]#[fg=$PRIMARY bg=$PRIMARYBG] #[fg=$PRIMARY bg=$PRIMARYBG]#I #W #[fg=$PRIMARYBG bg=terminal]"
}

if [[ $1 == "active" ]]; then
    echo "$(window_active_status)"
else
    echo "$(window_status)"
fi
