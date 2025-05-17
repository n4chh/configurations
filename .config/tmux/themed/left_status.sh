#!/usr/bin/env bash

source ~/.config/tmux/colors.sh

session="#[fg=$SOURCE]#[bg=$SOURCE fg=$WHITE] #[bg=$TAGBG fg=$TAGFG] #S#[fg=$TAGBG bg=terminal] "
echo "$session"
