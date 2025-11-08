#!/usr/bin/env bash
cd $1
source ./colors.sh

echo -n " "
echo -n "#[fg=$PRIMARY]$LEFT_ICON#[bg=$PRIMARY]"
echo -n "#[fg=$GREY bold]"
echo -n "#[fg=$PRIMARY bg=terminal]$RIGHT_ICON#[fg=terminal]"
echo -n " "
echo -n "#[fg=$SOURCE bold]#S "
echo -n "#[fg=$SOURCE nobold]❯#[fg=terminal] "
