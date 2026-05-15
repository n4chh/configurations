# Auto-switch fast-syntax-highlighting between ubuntu-dark and ubuntu-light
# based on GNOME system color scheme, checked before every prompt

return
_fsh_ubuntu_auto_theme() {
    local desired cache_file
    cache_file="/tmp/fsh_ubuntu_theme_${USER}"

    local scheme
    scheme=$(gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null)
    [[ "$scheme" == *"prefer-dark"* ]] && desired="ubuntu-dark" || desired="ubuntu-light"

    local current
    current=$(cat "$cache_file" 2>/dev/null)
    if [[ "$desired" != "$current" ]]; then
		fast-theme "XDG:$desired" &>/dev/null
        echo "$desired" > "$cache_file"
    fi
}
add-zsh-hook precmd _fsh_ubuntu_auto_theme
