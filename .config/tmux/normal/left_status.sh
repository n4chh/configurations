#!/usr/bin/env bash

source ./colors.sh

session="#[fg=$SOURCE]#[bg=$SOURCE fg=$PRIMARYFG]㉿ #[bg=$TAGBG fg=$TAGFG] #S#[fg=$TAGBG bg=terminal] "
echo "$session"
