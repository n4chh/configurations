mode=$(defaults read -g AppleInterfaceStyle 2>/dev/null || echo Light)

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
    TAGBG=#494949
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
