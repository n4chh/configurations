#!/usr/bin/env bash
# herdr theme toggle — swap the [theme] region of config.toml between the
# Kanagawa Lotus (light) and Wave (dark) tunings, then reload the server.
#
# No background service: bound to prefix+shift+t in config.toml.
#   toggle-theme.sh          flip to the other mode
#   toggle-theme.sh light    force light
#   toggle-theme.sh dark     force dark
#   toggle-theme.sh auto     match current macOS appearance
#
# Only the text BETWEEN the THEME:START / THEME:END markers is rewritten;
# keybindings and commands below the markers are never touched.
set -euo pipefail

CONF="$HOME/.config/herdr/config.toml"
HERDR="/opt/homebrew/bin/herdr"
START='# <<<THEME:START>>>'
END='# <<<THEME:END>>>'

read_light() {
cat <<'LIGHT'
# <<<THEME:START>>> managed by toggle-theme.sh — do not hand-edit inside markers
# THEME-MODE: light
# Kanagawa Lotus (light) — warm-tan ramp derived from your Ghostty bg #f2e9de
# (custom kanagawa-lotus-opencode). Ramp monotonic; text clears 4.58:1 on all.
[theme]
auto_switch = false
name = "terminal"          # inherit host palette; custom tokens pin the chrome

[theme.custom]
panel_bg    = "reset"      # inherit Ghostty light bg #f2e9de
surface_dim = "#ece1d3"    # subtle fill, 1.07:1 vs bg
surface0    = "#e3d6c5"    # panels / tabs, 1.19:1 vs bg
surface1    = "#d8c9b5"    # raised elements, 1.35:1 vs bg
overlay0    = "#8a8980"    # inactive borders (palette 8); 2.93:1 — subtle only
overlay1    = "#6b6a62"    # active/visible borders; 4.53:1 — safe divider
text        = "#545464"    # primary ink (lotusInk1/fg); 6.18:1
subtext0    = "#43436c"    # lotusInk2 — darker/emphasis, not lighter muted
red         = "#c84053"    # lotusRed — accent/large only (4.05:1)
green       = "#6f894e"    # lotusGreen — UI/large only (3.26:1)
yellow      = "#77713f"    # lotusYellow (dark olive) — accent/large (4.14:1)
blue        = "#4d699b"    # lotusBlue2 — safe for body/nav (4.59:1)
teal        = "#597b75"    # lotusAqua — large/UI marks (3.87:1)
peach       = "#cc6d00"    # lotusOrange2 — icons/large only (3.04:1, weakest)
mauve       = "#624c83"    # lotusViolet — safe everywhere (6.07:1)

[ui]
accent = "#4d699b"         # lotusBlue2 — active borders / nav highlight
agent_panel_sort = "spaces"
# <<<THEME:END>>>
LIGHT
}

read_dark() {
cat <<'DARK'
# <<<THEME:START>>> managed by toggle-theme.sh — do not hand-edit inside markers
# THEME-MODE: dark
# Kanagawa Wave (dark) — canonical sumiInk ramp over Ghostty bg #1f1f28.
# Verified WCAG: text/subtext AAA; see per-token contrast ratios.
[theme]
auto_switch = false
name = "terminal"          # inherit host palette; custom tokens pin the chrome

[theme.custom]
panel_bg    = "reset"      # inherit Ghostty Wave bg sumiInk1 #1f1f28
surface_dim = "#16161d"    # sumiInk0 — 1.10:1 vs bg (darker than bg, correct)
surface0    = "#2a2a37"    # sumiInk2 — 1.16:1 vs bg
surface1    = "#363646"    # sumiInk3 — 1.38:1 vs bg — ramp monotonic
overlay0    = "#54546d"    # sumiInk4 — 2.23:1 vs bg — subtle/inactive only
overlay1    = "#727169"    # fujiGray — 3.33:1 vs bg — active chrome
text        = "#dcd7ba"    # fujiWhite — 11.26:1 vs bg (AAA)
subtext0    = "#c8c093"    # oldWhite — 8.89:1 vs bg (AAA)
red         = "#c34043"    # autumnRed — 3.22:1 vs bg — status dot/border, not text
green       = "#76946a"    # wave green — 4.84:1 vs bg
yellow      = "#e6c384"    # carpYellow — 9.73:1 vs bg
blue        = "#7e9cd8"    # crystalBlue — 5.94:1 vs bg
teal        = "#7aa89f"    # waveAqua2 — 6.17:1 vs bg
peach       = "#ffa066"    # surimiOrange — 8.15:1 vs bg
mauve       = "#957fb8"    # oniViolet — 4.67:1 vs bg

[ui]
accent = "#7e9cd8"         # crystalBlue — classic Wave highlight, active borders
agent_panel_sort = "spaces"
# <<<THEME:END>>>
DARK
}

# Current mode from the marker line inside config.toml (default light).
current="light"
if grep -q '^# THEME-MODE: dark' "$CONF" 2>/dev/null; then current="dark"; fi

# Resolve target mode from arg, else flip.
case "${1:-flip}" in
    light) target="light" ;;
    dark)  target="dark" ;;
    auto)
        if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null || true)" == "Dark" ]]; then
            target="dark"; else target="light"; fi ;;
    flip|"") target=$([[ "$current" == "light" ]] && echo dark || echo light) ;;
    *) echo "usage: toggle-theme.sh [light|dark|auto|flip]" >&2; exit 2 ;;
esac

# Render the new theme block for the target mode.
if [[ "$target" == "dark" ]]; then block="$(read_dark)"; else block="$(read_light)"; fi

# Splice: replace everything from START to END (inclusive) with the new block.
# Written to a temp file then moved atomically so a failure can't corrupt config.
tmp="$(mktemp "$HOME/.config/herdr/.config.XXXXXX")"
trap 'rm -f "$tmp"' EXIT
BLOCK="$block" awk -v s="$START" -v e="$END" '
    index($0, s) == 1 { print ENVIRON["BLOCK"]; skip=1; next }
    skip && index($0, e) == 1 { skip=0; next }
    skip { next }
    { print }
' "$CONF" > "$tmp"

# Sanity: the new file must still contain both markers and the [keys] table.
if ! grep -q "$START" "$tmp" || ! grep -q "$END" "$tmp" || ! grep -q '^\[keys\]' "$tmp"; then
    echo "toggle-theme: splice sanity check failed; config left unchanged" >&2
    exit 1
fi

mv -f "$tmp" "$CONF"
trap - EXIT

"$HERDR" server reload-config >/dev/null 2>&1 || true
