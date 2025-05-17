#!/usr/bin/env bash

source ~/.config/tmux/colors.sh

session="#[fg=$SOURCE]#[bg=$SOURCE fg=$TAGFG] #[bg=$TAGBG fg=$TAGFG] #S#[fg=$TAGBG bg=terminal] "
echo "$session"
