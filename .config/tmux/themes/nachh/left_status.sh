#!/usr/bin/env bash
cd $1
source ./colors.sh

session="#[fg=$SOURCE]#[bg=$SOURCE fg=$TAGBG] #[bg=$TAGBG fg=$TAGFG] #S#[fg=$TAGBG bg=terminal] "
echo "$session"
