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

tmux setw -g window-status-separator ' '
tmux setw -g window-status-format "#($PWD/window_status.sh $PWD)"
tmux setw -g window-status-current-format "#($PWD/window_status.sh $PWD active)"

tmux set -g mouse on
tmux set -g pane-border-status top
tmux set -g pane-border-lines heavy
tmux set -g pane-border-style 'fg=terminal'
tmux set -g pane-active-border-style "fg=$PRIMARY"
tmux set -g status-style "bg=terminal fg=$PRIMARY"
tmux set -g pane-border-format ""

tmux set -g status-position top
# tmux set -g status-position bottom
