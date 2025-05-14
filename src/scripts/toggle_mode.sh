#!/bin/bash
notify() {
    local text=""
    if [[ $1 == "dark" ]]; then
        text="Cambiando a modo oscuro."
    else
        text="Cambiando a modo claro."
    fi
    local icon="preferences-system-linux"
    local timeout=3000
    local app="Sistema"

    notify-send "$text" -a "$app" -i "$icon" -e -t "$timeout"
}

wallust_toggle_mode() {
    local wallust_config="$HOME/.config/wallust/wallust.toml"
    local pallete_dark="dark16"
    local pallete_light="light16"
    if [ "$next_mode" = "Dark" ]; then
        sed -i 's/^palette = .*/palette = "'"$pallete_dark"'"/' "$wallust_config"
    else
        sed -i 's/^palette = .*/palette = "'"$pallete_light"'"/' "$wallust_config"
    fi
}

qt_toogle_mode() {
    if [ "$next_mode" = "Dark" ]; then
        kvantum_theme="catppuccin-mocha-blue"
        #qt5ct_color_scheme="$HOME/.config/qt5ct/colors/Catppuccin-Mocha.conf"
        #qt6ct_color_scheme="$HOME/.config/qt6ct/colors/Catppuccin-Mocha.conf"
    else
        kvantum_theme="catppuccin-latte-blue"
        #qt5ct_color_scheme="$HOME/.config/qt5ct/colors/Catppuccin-Latte.conf"
        #qt6ct_color_scheme="$HOME/.config/qt6ct/colors/Catppuccin-Latte.conf"
    fi

    sed -i "s|^color_scheme_path=.*$|color_scheme_path=$qt5ct_color_scheme|" "$HOME/.config/qt5ct/qt5ct.conf"
    sed -i "s|^color_scheme_path=.*$|color_scheme_path=$qt6ct_color_scheme|" "$HOME/.config/qt6ct/qt6ct.conf"
    kvantummanager --set "$kvantum_theme"
}

set_custom_gtk_theme() {
    local mode=$1
    local gtk_themes_directory="$HOME/.themes"
    local icon_directory="$HOME/.icons"
    local color_setting="org.gnome.desktop.interface color-scheme"
    local theme_setting="org.gnome.desktop.interface gtk-theme"
    local icon_setting="org.gnome.desktop.interface icon-theme"

    if [ "$mode" == "Light" ]; then
        local search_keywords="*Light*"
        gsettings set $color_setting 'prefer-light'
    elif [ "$mode" == "Dark" ]; then
        local search_keywords="*Dark*"
        gsettings set $color_setting 'prefer-dark'
    else
        echo "Invalid mode provided."
        return 1
    fi

    local themes=()
    local icons=()

    while IFS= read -r -d '' theme_search; do
        themes+=("$(basename "$theme_search")")
    done < <(find "$gtk_themes_directory" -maxdepth 1 -type d -iname "$search_keywords" -print0)

    while IFS= read -r -d '' icon_search; do
        icons+=("$(basename "$icon_search")")
    done < <(find "$icon_directory" -maxdepth 1 -type d -iname "$search_keywords" -print0)

    if [ ${#themes[@]} -gt 0 ]; then
        if [ "$mode" == "Dark" ]; then
            local selected_theme=${themes[$RANDOM % ${#themes[@]}]}
        else
            local selected_theme=${themes[$RANDOM % ${#themes[@]}]}
        fi
        echo "Selected GTK theme for $mode mode: $selected_theme"
        gsettings set $theme_setting "$selected_theme"

        # Flatpak GTK apps (themes)
        if command -v flatpak &>/dev/null; then
            flatpak --user override --filesystem=$HOME/.themes
            sleep 0.5
            flatpak --user override --env=GTK_THEME="$selected_theme"
        fi
    else
        echo "No $mode GTK theme found"
    fi

    if [ ${#icons[@]} -gt 0 ]; then
        if [ "$mode" == "Dark" ]; then
            local selected_icon=${icons[$RANDOM % ${#icons[@]}]}
        else
            local selected_icon=${icons[$RANDOM % ${#icons[@]}]}
        fi
        echo "Selected icon theme for $mode mode: $selected_icon"
        gsettings set $icon_setting "$selected_icon"

        ## QT5ct icon_theme
        sed -i "s|^icon_theme=.*$|icon_theme=$selected_icon|" "$HOME/.config/qt5ct/qt5ct.conf"
        sed -i "s|^icon_theme=.*$|icon_theme=$selected_icon|" "$HOME/.config/qt6ct/qt6ct.conf"

        # Flatpak GTK apps (icons)
        if command -v flatpak &>/dev/null; then
            flatpak --user override --filesystem=$HOME/.icons
            sleep 0.5
            flatpak --user override --env=ICON_THEME="$selected_icon"
        fi
    else
        echo "No $mode icon theme found"
    fi
}

swaync_toogle_mode() {
    local swaync_path="$HOME/.config/swaync"
    local mode=$1
    killall swaync
    killall -SIGUSR2 swaync
    if [ "$mode" = "dark" ]; then
        ln -sf "$swaync_path/style-dark.css" "$swaync_path/style.css"
    else
        ln -sf "$swaync_path/style-light.css" "$swaync_path/style.css"
    fi
    sleep 0.5
    swaync >/dev/null 2>&1 &
}

alacritty_toggle_mode() {
    local dark="github_dark"
    local light="github_light"
    local alacritty_conf="$HOME/.config/alacritty/alacritty.toml"
    local mode=$1
    if [[ $mode == "dark" ]]; then
        sed -i "s/$light/$dark/" "$alacritty_conf"
    else
        sed -i "s/$dark/$light/" "$alacritty_conf"
    fi
}

kde_toggle_mode() {
    local mode=$1

    echo $mode
    if [[ $mode == "dark" ]]; then
        lookandfeeltool -a "$kde_dark"

    else
        lookandfeeltool -a "$kde_light"
    fi
}

gnome_toggle_mode() {
    local mode=$1

    if [[ $mode == "dark" ]]; then
        gsettings set org.gnome.desktop.interface color-scheme $gnome_dark
        # gnome-extensions disable light-style@gnome-shell-extensions.gcampax.github.com
    else
        gsettings set org.gnome.desktop.interface color-scheme $gnome_light
        # gnome-extensions enable light-style@gnome-shell-extensions.gcampax.github.com

    fi
}

kde_dark="org.manjaro.breath-dark.desktop"
kde_light="org.manjaro.breath-light.desktop"
gnome_light="'prefer-light'"
gnome_dark="'prefer-dark'"
SESSION=gnome
get_current_mode() {
    if [[ $SESSION == "gnome" ]]; then
        current_mode=$(gsettings get org.gnome.desktop.interface color-scheme)
        if [[ "$current_mode" == "$gnome_light" ]]; then
            echo "dark"
        else
            echo "light"
        fi
    elif [[ $SESSION == "kde" ]]; then
        current_mode="$(kreadconfig6 --key LookAndFeelPackage)"
        if [[ "$current_mode" == "$kde_light" ]]; then
            echo "dark"
        else
            echo "light"
        fi

    else
        exit 1
    fi
}

waybar_reset() {
    echo
    # killall waybar
    # waybar &
}

ags_toggle_mode() {
    local mode=$1
}

if [ -z $1 ] || ([ $1 != "dark" ] && [ $1 != "light" ]); then
    mode="$(get_current_mode)"
else
    mode=$1
fi
# notify $mode
alacritty_toggle_mode $mode

if [[ $SESSION == "gnome" ]]; then
    gnome_toggle_mode $mode
elif [[ $SESSION == "kde" ]]; then
    kde_toggle_mode $mode
else
    exit
fi

# waybar_reset
# swayn
