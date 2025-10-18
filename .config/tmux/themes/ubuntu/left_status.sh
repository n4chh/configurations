#!/usr/bin/env bash
cd $1
source ./colors.sh

echo -n " "
# echo -n "#[fg=$SOURCE]$LEFT_ICON"
echo -n "#[bg=$SOURCE fg=$WHITE bold]   "
echo -n "#[bold]#S "
echo -n "#[fg=$SOURCE bg=terminal]$RIGHT_ICON"
echo -n "#[fg=terminal] "
