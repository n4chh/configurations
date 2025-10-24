#!/usr/bin/env bash
cd $1
source ./colors.sh

echo -n "#[fg=$WHITE bg=$TAG_BG bold] #S "
echo -n "#[fg=$SOURCE bold]"
echo -n "#{?#{==:#{pane_mode},copy-mode},[C],}"
echo -n "#{?#{pane_mode},,[N]}"
echo -n " #[fg=$PRIMARY nobold]❯#[fg=$TAG_BG] "
