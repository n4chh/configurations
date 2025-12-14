#!/usr/bin/env bash
# Detects if mode is Light or Dark
detect_mode() {
	local system="$(uname -a)"
	local mode=""
	shopt -s nocasematch
	if [[ $system =~ Linux ]];then
		mode=$(gsettings get org.gnome.desktop.interface color-scheme)
	else
		mode=$(defaults read -g AppleInterfaceStyle 2>/dev/null || echo Light)
	fi
	shopt -u nocasematch
	echo -n $mode | tr '[:upper:]' '[:lower:]'
}
