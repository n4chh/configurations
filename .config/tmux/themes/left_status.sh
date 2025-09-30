#!/usr/bin/env bash
cd $1
source ./colors.sh

echo -n " #[fg=$LAVENDER bold]#S "
echo -n "#[fg=$PEACH bold]"
echo -n "#{?#{==:#{pane_mode},copy-mode},[C],}"
echo -n "#{?#{pane_mode},,[N]}"
echo -n " #[fg=$MAUVE nobold]❯#[fg=terminal] "
