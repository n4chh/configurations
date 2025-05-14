 #!/bin/sh

TARGET="$(cat '/Users/nachh/.local/target.txt')"
ICON=""
ICON="󰣉"
if [ -z "$TARGET" ]; then
	ICON="󰗝"
	LABELCOLOR=0xffcccccc
	TARGET="[ No Target ]"
	# ICONBACKCOLOR="0xffeadf0c"
	ICONBACKCOLOR="0xffff3a60"
	ICONCOLOR=0xffffffff
else
	TARGET="$(echo [ $TARGET ])"
	# TARGET="$(echo [ \$TARGET = 42Madrid-Cyber ])"
	LABELCOLOR=0xffffffff
	# ICONBACKCOLOR="0xffeadf0c"
	ICONBACKCOLOR="0xffff3a60"
	ICONCOLOR=0xffffffff
fi
FONT="Hack Nerd Font:Bold:23.0"
Y=0
H=27
BW=1

sketchybar --set $NAME label="$TARGET" label.color="$LABELCOLOR" \
					   icon="$ICON" icon.color="$ICONCOLOR" icon.background.color=$ICONBACKCOLOR \
					   icon.background.corner_radius=16 icon.y_offset=$Y icon.background.height="$H" \
					   icon.background.border_width="$BW" icon.background.border_color=0xff000000 \
					   icon.font="$FONT" icon.padding_right=3 icon.padding_left=4


