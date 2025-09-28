#!/usr/bin/env bash
cd $1
source ./colors.sh

echo -n " #[fg=$SOURCE bold]#S "
echo -n "#[fg=$PEACH bold]"
echo -n "#{?#{==:#{pane_mode},copy-mode},[C],}"
echo -n "#{?#{pane_mode},,[N]}"
echo -n " #[fg=$SOURCE nobold]❯#[fg=terminal] "
