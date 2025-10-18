#!/usr/bin/env bash
cd $1
source ./colors.sh

session="#[fg=$SOURCE]#[bg=$SOURCE fg=$AWSPRIMARY]  #[bg=$TAGBG fg=$TAGFG] #S#[fg=$TAGBG bg=terminal] "
echo -n " "
echo -n "#[fg=$PRIMARY bold]  "
echo -n "#[fg=$SOURCE bold]#S "
echo -n "#[fg=$SOURCE nobold]❯#[fg=terminal] "
