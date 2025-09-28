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

# icons
# ''
# ''
# ''
# ''

source $PWD/colors.sh

tmux setw -g window-status-format "#($PWD/window_status.sh $PWD)"
tmux setw -g window-status-current-format "#($PWD/window_status.sh $PWD active)"

tmux set -g mouse on

tmux set-option -g pane-border-lines heavy
tmux set-option -g pane-border-format ''
tmux set-option -g pane-border-status top
tmux set-option -g pane-border-style "fg=$OVERLAY0"
tmux set-option -g pane-active-border-style "fg=$SAPPHIRE"
tmux set-option -g status-style "bg=terminal fg=$SOURCE"

tmux set -g message-style "fg=$TEXT bg=$SURFACE1"
tmux set -g message-command-style "bg=$TEXT fg=$SURFACE1"

tmux set -g status-position top
# tmux set -g status-position bottom
