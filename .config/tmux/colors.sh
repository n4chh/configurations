mode=$(defaults read -g AppleInterfaceStyle 2>/dev/null || echo Light)

BLUE=#3487ed
WHITE=#ffffff

SOURCE=#fe5d26
PRIMARY=#f2c078
SECONDARY=#c1dbb3
TERCIARY=#faedca
if [[ $mode == "Dark" ]]; then
    TAGBG=#494949
    TAGFGDIM=#909090
    TAGFG=terminal
else
    TAGFG=terminal
    TAGFGDIM=#909090
    TAGBG=#d4d4d4
fi
