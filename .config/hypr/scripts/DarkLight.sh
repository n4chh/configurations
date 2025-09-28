#!/usr/bin/env bash


change_template ()
{
	local conf_file="$1"
	local current_template="$2"
	local new_template="$3"


	local output="$(sed -i "s|$current_template|$new_template|g" "$conf_file" 2>&1)"
	if [ $? -eq 0 ]; then
		echo "[!] There was an error when trying to update hyprland config."
		echo "FILENAME: $conf_file"
		echo "CURRENT TEMPLATE: $current_template"
		echo "NEW TEMPLATE: $new_template"
		echo "______________"
		echo "COMMAND OUPUT:"
		echo "$output"
	fi
}


change_hypr_theme ()
{
	local current_mode="$1"
	local config_file="$HOME/.config/hypr/hyprland.conf"
	local DARK_THEME="catppuccin-mocha"
	local LIGHT_THEME="catppuccin-latte"

	case "$current_mode" in
		"'prefer-dark'"|"dark"|"Dark"|"DARK")
			change_template $config_file $DARK_THEME $LIGHT_THEME
		;;
	
		"'default'"|"light"|"Light"|"LIGHT")
			change_template $config_file $LIGHT_THEME $DARK_THEME
		;;

		*)
			echo "[!] There was an error when trying to update hyprland theme."
		;;
	esac
}


change_wallpaper () {
	local current_mode="$1"
	local conf_file="$HOME/.config/hypr/hyprpaper.conf"
	local DARK_WALLPAPER="minimal-mojave-night.png"
	local LIGHT_WALLPAPER="minimal-mojave-day.png"
	
	case "$current_mode" in
		"'prefer-dark'"|"dark"|"Dark"|"DARK")
			change_template $config_file $DARK_WALLPAPER $LIGHT_WALLPAPER
			hyprctl hyprpaper reload , "$HOME/Pictures/$LIGHT_WALLPAPER"
		;;
	
		"'default'"|"light"|"Light"|"LIGHT")
			change_template $config_file $LIGHT_WALLPAPER $DARK_WALLPAPER
			hyprctl hyprpaper reload , "$HOME/Pictures/$DARK_WALLPAPER"
		;;

		*)
			echo "[!] There was an error when trying to change wallpaper."
		;;
	esac
}


if [ -z $1 ]; then
	current_mode="$(gsettings get org.gnome.desktop.interface color-scheme)"
else
	# If theme is provided as first argument, the program will try to change to 
	# the provided theme
	current_mode="$1"
	case "$current_mode" in
		"'prefer-dark'"|"dark"|"Dark"|"DARK")
			current_mode="light"
		;;
		"'default'"|"light"|"Light"|"LIGHT")
			current_mode="dark"
		;;
		*)
			echo "[!] Unknown mode provided"
		;;
	esac
fi

change_hypr_theme $current_mode
change_wallpaper $current_mode


change_hypr_theme $current_mode
