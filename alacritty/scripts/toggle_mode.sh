#!/bin/bash
CONFIG_PATH="$HOME/.config/alacritty/alacritty.toml"
TIMEOUT=3000
notify() {
	notify-send -t ${TIMEOUT} -a alacritty-theme-toggle 'Switched alacritty theme:' $1
}
dark="hyper"
light="enfocado_light"
(
	grep -q "$light" $CONFIG_PATH &&
		sed -i '' "s/$light/$dark/" "$CONFIG_PATH"
	# notify "dark" &&
) || (
	grep -q "$dark" $CONFIG_PATH &&
		sed -i '' "s/$dark/$light/" "$CONFIG_PATH"
	# notify "light"
)
