#!/bin/bash

BATT_PERCENT=$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)
CHARGING=$(pmset -g batt | grep 'AC Power')
ICONCOLOR=0xffffffff
sketchybar --set ${NAME} icon.color=0xff989898

if [[ ${CHARGING} != "" ]]; then
  sketchybar --set ${NAME} icon="󰠠" icon.color=0xff8aff8a
  sketchybar --set ${NAME} label="${BATT_PERCENT}%"
  exit 0
fi

case ${BATT_PERCENT} in
    100) ICON="󰪥" ;;
    9[0-9]) ICON="󰪤" ;;
    8[0-9]) ICON="󰪤" ;;
    7[0-9]) ICON="󰪣" ;;
    6[0-9]) ICON="󰪢" ;;
    5[0-9]) ICON="󰪡" ;;
    4[0-9]) ICON="󰪠" ;;
    3[0-9]) ICON="󰪟" ;;
    2[0-9]) ICON="󰪞"; ICONCOLOR=0xffff2e2e ;;
    1[0-9]) ICON="󰪞"; ICONCOLOR=0xffff2e2e;;
    *) ICON=""; ICONCOLOR=0xffff2e2e
esac

sketchybar --set ${NAME} icon="${ICON}" icon.color=$ICONCOLOR icon.font="Hack Nerd Font:Bold:22.0"
sketchybar --set ${NAME} label="${BATT_PERCENT}%"
