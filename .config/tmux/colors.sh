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

if [[ $mode == "dark" ]]; then
    SOURCE=#1960a3
    PRIMARY=#a3c9fe
    SECONDARY=#bcc7db
    PRIMARYBG=#1e4876
    SECONDARYBG=#3c4758
    SECONDARYFG=#263141
    PRIMARYFG=#00315b
    TAGBG=#494949
    TAGFG=terminal
    TAGFGDIM=#909090
else
    SOURCE=#1960a3
    PRIMARY=#39608f
    SECONDARY=#545f70
    PRIMARYBG=#d3e4ff
    SECONDARYBG=#d8e3f8
    SECONDARYFG=#ffffff
    PRIMARYFG=#ffffff
    TAGFG=terminal
    TAGFGDIM=#909090
    TAGBG=#d4d4d4
fi
