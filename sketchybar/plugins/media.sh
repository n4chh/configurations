#!/bin/bash
STATE="$(echo "$INFO" | jq -r '.state')"

if [ "$STATE" = "playing" ]; then
  MEDIA="$(echo "$INFO" | jq -r '.title + " - " + .artist')"
  ICONBACKCOLOR=0xff000000
  ICONCOLOR=0xff81b71a
  sketchybar --set $NAME label="$MEDIA" drawing=on icon='󰓇' \
    icon.color="$ICONCOLOR" icon.background.color=$ICONBACKCOLOR \
    icon.background.y_offset=0 icon.background.border_width=13 \
    icon.background.height=24 icon.font="Hurmit Nerd Font:Bold:26.0"
else
  sketchybar --set $NAME drawing=off
fi
