#!/usr/bin/env bash
tmux set -g default-terminal "screen-256color"
# tmux set -g status-style "#(./colors.sh print)"
tmux set -g status-justify left

tmux set -g status on
tmux set -g status-right-length 200
tmux set -g status-left-length 40
tmux set -g status-interval 1
tmux set -g status-left "#($PWD/left_status.sh $PWD)"
tmux set -g status-right "#($PWD/right_status.sh $PWD)"
tmux set -g pane-base-index 1

# icons
# ''
# ''
# ''
# ''

source $PWD/colors.sh

script_path="$HOME/.config/tmux/scripts"
tmux bind-key -Troot MouseDown1Status run-shell "$script_path/status-click.sh #{mouse_status_range} #{window_id}"

command="display-popup -T '🗄️Session selector' -E '$script_path/sessions-fzf.sh'"
tmux bind-key -T root MouseDown1StatusLeft "$command"
tmux bind-key -Troot F1 "$command"

# tmux bind-key -n F1 "tmux display-


tmux set -g window-status-format "#($PWD/window_status.sh $PWD)"
tmux set -g window-status-current-format "#($PWD/window_status.sh $PWD active)"

tmux set -g mouse on

tmux set -g pane-border-lines heavy
tmux set -g pane-border-format ''
tmux set -g pane-border-status top
tmux set -g pane-border-style "fg=$OVERLAY0"
tmux set -g pane-active-border-style "fg=$SAPPHIRE"
tmux set -g status-style "bg=terminal fg=$ROSEWATER"
tmux set -g message-style "fg=$TEXT bg=$SURFACE1"
tmux set -g message-command-style "bg=$TEXT fg=$SURFACE1"

tmux set -g status-position top
# tmux set -g status-position bottom
