#!/usr/bin/env bash

source ./colors.sh

session="#[fg=$SOURCE bg=terminal]#[bg=$SOURCE fg=colour255] #[bg=$PRIMARYBG fg=$PRIMARY] #S#[fg=$PRIMARYBG bg=terminal] "
echo "$session"
