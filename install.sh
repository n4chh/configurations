#!/bin/bash

function log() {
    case "$1" in
    0 | SUCCESS)
        shift
        echo "[$(tput setaf 2)+$(tupt sgr0)] $@"
        ;;
    1 | INFO)
        shift
        echo "[$(tput setaf 4)*$(tupt sgr0)] $@"
        ;;
    2 | WARNING)
        shift
        echo "[$(tput setaf 3)!$(tupt sgr0)] $@"
        ;;
    3 | ERROR)
        shift
        echo "[$(tput setaf 1 bold)X$(tupt sgr0)] $@"
        ;;
    *)
        echo "$@"
        ;;
    esac

}

function get_wallpaper_path() {
    osascript -e '
    tell application "Finder"
    set theDesktopPic to desktop picture as alias
    set theName to posix path of theDesktopPic
    end tell'
}

function download_nerd_fonts() {
    curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip -o /tmp/JetBrainsMono.zip
    unzip -d ~/Library/Fonts/ /tmp/JetBrainsMono.zip
}

if ! which matugen; then
    log 3 "matugen is needed. "
    log 1 "Installing it . . ."
    if ! cargo install matugen; then
        log 3 There was an error while installing matugen.
        exit 1
    fi
fi

-d ~/.config || mkdir ~/.config

cp -r src/* ~/.config
log 0 Source files copied
wallpaper="$(get_wallpapper_path)"
if ! [ -f "$wallpaper" ]; then
    log 3 "Could not detect actual wallpaper."
    log 1 "Info:"
    echo $wallpaper
    exit 1
fi
matugen image "$wallpaper"

log 0 "Setup completed"
