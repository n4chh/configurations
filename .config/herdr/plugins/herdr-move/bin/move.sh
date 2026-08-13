#!/usr/bin/env bash
# herdr-move — move the focused pane / whole tab across tabs and workspaces.
#
# Runs as a herdr plugin PANE entrypoint (placement = overlay), so it is a
# native herdr-owned pane. herdr passes HERDR_PLUGIN_CONTEXT_JSON describing
# the pane that was focused when the action fired — we use that, NOT
# HERDR_PANE_ID (which is this picker pane itself).
#
# Usage: move.sh <mode>
#   pane-to-tab        move focused pane → chosen tab (or new tab)
#   pane-to-workspace  move focused pane → chosen workspace (or new workspace)
#   tab-to-workspace   move the focused pane's whole tab → chosen workspace
set -euo pipefail

mode="${1:?usage: move.sh <pane-to-tab|pane-to-workspace|tab-to-workspace>}"
ctx="${HERDR_PLUGIN_CONTEXT_JSON:-}"

# Fall back to HERDR_ACTIVE_*/HERDR_* if context JSON is somehow absent.
jqget() { [[ -n "$ctx" ]] && jq -r --arg k "$1" '.[$k] // empty' <<<"$ctx" 2>/dev/null || true; }
pane="$(jqget focused_pane_id)"; [[ -z "$pane" ]] && pane="${HERDR_ACTIVE_PANE_ID:-${HERDR_PANE_ID:-}}"
tab="$(jqget tab_id)";           [[ -z "$tab"  ]] && tab="${HERDR_ACTIVE_TAB_ID:-${HERDR_TAB_ID:-}}"
ws="$(jqget workspace_id)";      [[ -z "$ws"   ]] && ws="${HERDR_ACTIVE_WORKSPACE_ID:-${HERDR_WORKSPACE_ID:-}}"

die() { printf '\n  \033[31m%s\033[0m\n' "$*"; sleep 1.2; exit 1; }
[[ -n "$pane" ]] || die "Could not determine the focused pane."

# --- tiny numbered picker (no fzf). Prints the chosen id (empty = "new"). ---
# args: prompt, then lines "id<TAB>label"; a leading "＋ new…" row has empty id.
pick() {
  local prompt="$1"; shift
  local -a ids=() labels=()
  local line
  for line in "$@"; do
    ids+=("${line%%$'\t'*}")
    labels+=("${line#*$'\t'}")
  done
  printf '\033[1;35m  %s\033[0m\n\n' "$prompt"
  local i
  for i in "${!labels[@]}"; do
    printf '   \033[36m%2d\033[0m  %s\n' "$((i+1))" "${labels[$i]}"
  done
  printf '\n  \033[90mnumber = move · q = cancel\033[0m\n\n  > '
  local choice
  read -r choice
  [[ "$choice" == "q" || -z "$choice" ]] && { printf '\n  cancelled\n'; sleep 0.4; exit 0; }
  [[ "$choice" =~ ^[0-9]+$ ]] || die "Not a number: $choice"
  local idx=$((choice-1))
  [[ $idx -ge 0 && $idx -lt ${#ids[@]} ]] || die "Out of range: $choice"
  PICKED_ID="${ids[$idx]}"
  PICKED_LABEL="${labels[$idx]}"
  # Strip ANSI so success messages read cleanly (the "＋ new…" row is colored).
  PICKED_LABEL="$(printf '%s' "$PICKED_LABEL" | sed 's/\x1b\[[0-9;]*m//g')"
}

case "$mode" in
  pane-to-tab)
    mapfile -t rows < <(
      printf '\t\033[32m＋ new tab\033[0m\n'
      herdr tab list 2>/dev/null | jq -r --arg cur "$tab" '
        .result.tabs[] | select(.tab_id != $cur)
        | "\(.tab_id)\t#\(.number)  \(.label)   (\(.pane_count)p)  [\(.workspace_id)]"'
    )
    pick "Move pane $pane → tab:" "${rows[@]}"
    if [[ -z "$PICKED_ID" ]]; then
      herdr pane move "$pane" --new-tab --focus >/dev/null
      printf '\n  \033[32m✓\033[0m moved to a new tab\n'
    else
      herdr pane move "$pane" --tab "$PICKED_ID" --split right --focus >/dev/null
      printf '\n  \033[32m✓\033[0m moved → %s\n' "$PICKED_LABEL"
    fi
    sleep 0.5
    ;;

  pane-to-workspace)
    mapfile -t rows < <(
      printf '\t\033[32m＋ new workspace\033[0m\n'
      herdr workspace list 2>/dev/null | jq -r --arg cur "$ws" '
        .result.workspaces[] | select(.workspace_id != $cur)
        | "\(.workspace_id)\t#\(.number)  \(.label)   (\(.tab_count) tabs, \(.pane_count)p)"'
    )
    pick "Move pane $pane → workspace:" "${rows[@]}"
    if [[ -z "$PICKED_ID" ]]; then
      herdr pane move "$pane" --new-workspace --focus >/dev/null
      printf '\n  \033[32m✓\033[0m moved to a new workspace\n'
    else
      active_tab="$(herdr workspace list 2>/dev/null | jq -r --arg w "$PICKED_ID" \
        '.result.workspaces[] | select(.workspace_id==$w) | .active_tab_id')"
      if [[ -n "$active_tab" && "$active_tab" != "null" ]]; then
        herdr pane move "$pane" --tab "$active_tab" --split right --focus >/dev/null
      else
        new_tab="$(herdr tab create --workspace "$PICKED_ID" --no-focus | jq -r '.result.tab.tab_id')"
        herdr pane move "$pane" --tab "$new_tab" --split right --focus >/dev/null
      fi
      printf '\n  \033[32m✓\033[0m moved → %s\n' "$PICKED_LABEL"
    fi
    sleep 0.5
    ;;

  tab-to-workspace)
    mapfile -t rows < <(
      printf '\t\033[32m＋ new workspace\033[0m\n'
      herdr workspace list 2>/dev/null | jq -r --arg cur "$ws" '
        .result.workspaces[] | select(.workspace_id != $cur)
        | "\(.workspace_id)\t#\(.number)  \(.label)   (\(.tab_count) tabs, \(.pane_count)p)"'
    )
    pick "Move WHOLE tab $tab → workspace:" "${rows[@]}"

    mapfile -t panes < <(herdr pane list 2>/dev/null \
      | jq -r --arg t "$tab" '.result.panes[] | select(.tab_id==$t) | .pane_id')
    [[ "${#panes[@]}" -gt 0 ]] || die "No panes found in tab $tab."

    first="${panes[0]}"; rest=("${panes[@]:1}")
    if [[ -z "$PICKED_ID" ]]; then
      res="$(herdr pane move "$first" --new-workspace --tab-label "moved" --no-focus)"
      dest_tab="$(jq -r '.result.move_result.created_tab.tab_id' <<<"$res")"
    else
      dest_tab="$(herdr tab create --workspace "$PICKED_ID" --no-focus | jq -r '.result.tab.tab_id')"
      herdr pane move "$first" --tab "$dest_tab" --split right --no-focus >/dev/null
    fi
    for p in "${rest[@]}"; do
      herdr pane move "$p" --tab "$dest_tab" --split right --no-focus >/dev/null
    done
    herdr tab focus "$dest_tab" >/dev/null 2>&1 || true
    printf '\n  \033[32m✓\033[0m moved %d pane(s) → %s\n' "${#panes[@]}" "${PICKED_LABEL:-new workspace}"
    sleep 0.6
    ;;

  *) die "Unknown mode: $mode" ;;
esac
