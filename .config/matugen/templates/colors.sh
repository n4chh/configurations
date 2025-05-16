kde_dark="org.manjaro.breath-dark.desktop"
kde_light="org.manjaro.breath-light.desktop"
gnome_light="'prefer-light'"
gnome_dark="'prefer-dark'"
SESSION=gnome
get_current_mode() {
    if [[ $SESSION == "gnome" ]]; then
        current_mode=$(gsettings get org.gnome.desktop.interface color-scheme)
        if [[ "$current_mode" == "$gnome_light" ]]; then
            echo "light"
        else
            echo "dark"
        fi
    elif [[ $SESSION == "kde" ]]; then
        current_mode="$(kreadconfig6 --key LookAndFeelPackage)"
        if [[ "$current_mode" == "$kde_light" ]]; then
            echo "light"
        else
            echo "dark"
        fi

    else
        exit 1
    fi
}

mode=$(get_current_mode)
BLUE=#3487ed
WHITE=#ffffff

if [[ $mode == "Dark" ]]; then
    SOURCE={{colors.source_color.dark.hex}}
    PRIMARY={{colors.primary.dark.hex}}
    SECONDARY={{colors.secondary.dark.hex}}
    PRIMARYBG={{colors.primary_container.dark.hex}}
    SECONDARYBG={{colors.secondary_container.dark.hex}}
    SECONDARYFG={{colors.on_secondary.dark.hex}}
    PRIMARYFG={{colors.on_primary.dark.hex}}
    TAGBG=#49949
    TAGFG=terminal
    TAGFGDIM=#909090
else
    SOURCE={{colors.source_color.light.hex}}
    PRIMARY={{colors.primary.light.hex}}
    SECONDARY={{colors.secondary.light.hex}}
    PRIMARYBG={{colors.primary_container.light.hex}}
    SECONDARYBG={{colors.secondary_container.light.hex}}
    SECONDARYFG={{colors.on_secondary.light.hex}}
    PRIMARYFG={{colors.on_primary.light.hex}}
    TAGFG=terminal
    TAGFGDIM=#909090
    TAGBG=#d4d4d4
fi
