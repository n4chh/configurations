#!/usr/bin/env bash
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

tmux setw -g window-status-separator ' '
tmux setw -g window-status-format "#($PWD/window_status.sh $PWD)"
tmux setw -g window-status-current-format "#($PWD/window_status.sh $PWD active)"

tmux set -g mouse on
