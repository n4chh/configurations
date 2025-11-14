#!/usr/bin/env bash
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


script_path="$HOME/.config/tmux/scripts"
tmux bind-key -Troot MouseDown1Status run-shell "$script_path/status-click.sh #{mouse_status_range} #{window_id}"


command="display-popup -T '🗄️Session selector' -E '$script_path/sessions-fzf.sh #{session_name}'"
tmux bind-key -T root MouseDown1StatusLeft "$command"
tmux bind-key -Troot F1 "$command"

tmux set -g window-status-format "#($PWD/window_status.sh $PWD)"
tmux set -g window-status-current-format "#($PWD/window_status.sh $PWD active)"
# tmux set -g window-status-current-format "#{E:window-status-format}"

tmux set -g mouse on

source $PWD/colors.sh

tmux set -g pane-border-lines heavy
tmux set -g status-position top
tmux set -g pane-border-status top
tmux set -g pane-border-format "#[fg=terminal]"
tmux set -g pane-border-format "#[fg=terminal]"
tmux set-option -g pane-border-style 'fg=terminal'
tmux set-option -g pane-active-border-style "fg=$ACCENT"
tmux set-option -g status-style "bg=terminal fg=$ACCENT"
# tmux set -g status-position bottom
