#!/bin/bash
CONFIG_PATH="$HOME/.config/alacritty/alacritty.toml"
TIMEOUT=3000
notify() {
	osascript -e "display notification \"${1}\" with title \"Tema de alacritty\" subtitle \"Tema configurado:\""
}
dark="hackthebox"
light="alabaster"
(
	grep -q "$light" $CONFIG_PATH &&
		sed -i '' "s/$light/$dark/" "$CONFIG_PATH"
	# && notify "$dark"
) || (
	grep -q "$dark" $CONFIG_PATH &&
		sed -i '' "s/$dark/$light/" "$CONFIG_PATH"
	# && notify "$light"
)
