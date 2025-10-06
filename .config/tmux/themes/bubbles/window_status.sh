#!/usr/bin/env bash

cd $1
source colors.sh
function window_status() {
    echo "#[fg=$SECONDARY]#[bg=$SECONDARY] #[fg=$TAGFGDIM bg=$TAGBG] #I #W #[fg=$TAGBG bg=terminal]"
}
function window_active_status() {
    echo "#[fg=$PRIMARY]#[bg=$PRIMARY fg=$SOURCE]#[fg=$PRIMARY bg=$TAGBG] #[fg=$TAGFG bg=$TAGBG]#I #W #[fg=$TAGBG bg=terminal]"
}

if [[ $2 == "active" ]]; then
    echo "$(window_active_status)"
else
    echo "$(window_status)"
fi
