
#!/usr/bin/env bash
# source ./colors.sh
tmux set -g default-terminal "screen-256color"
# tmux set -g status-style "#(./colors.sh print)"
tmux set -g status-justify left
tmux set -g pane-base-index 1

tmux set -g status on
tmux set -g status-right-length 200
tmux set -g status-left-length 40
tmux set -g status-interval 1
tmux set -g status-left "#($PWD/left_status.sh $PWD)"
tmux set -g status-right "#($PWD/right_status.sh $PWD)"


tmux set -g window-status-format "#($PWD/window_status.sh $PWD)"
tmux set -g window-status-current-format "#($PWD/window_status.sh $PWD active)"
# tmux set -g window-status-current-format "#{E:window-status-format}"

tmux set -g mouse on

source $PWD/colors.sh

tmux set -g status-position top
tmux set -g pane-border-status top
tmux set -g pane-border-format "#[fg=terminal]"
tmux set -g pane-border-format "#[fg=terminal]"
tmux set-option -g pane-border-style 'fg=terminal'
tmux set-option -g pane-active-border-style "fg=$SOURCE"
tmux set-option -g status-style "bg=terminal fg=$SOURCE"
# tmux set -g status-position bottom
