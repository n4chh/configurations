#!/usr/bin/env bash
theme=catppuccin
path="$HOME/.config/tmux/themes/$theme"
[[ -d "$path" ]] || exit 1
cd $path
ls >/tmp/ls
$path/colors.sh set
ls / >/tmp/ls
cd $path
source $path/theme.sh
# tmux source-file "$path/theme.tmux" >/tmp/test
