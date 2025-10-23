#!/usr/bin/env bash
# source ./colors.sh
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

command="\
if -F '#{==:#{mouse_status_range},window}' {\
    select-window\
} {\
    if -F '#{m/r:^kill,#{mouse_status_range}}' {\
        run-shell 'tmux kill-window -t #{s/^kill//:mouse_status_range}'\
    } {\
        if -F '#{==:#{mouse_status_range},new}' {\
            new-window\
        }\
    }\
}"

tmux bind-key -Troot MouseDown1Status $command


command='current_session="#{session_name}"\
    selected=$(tmux list-sessions -F "#{session_name}" | \
        fzf --prompt="Select session: " \
            --header="Current: $current_session" \
            --preview="tmux list-windows -t {}" \
            --preview-window=right:60% \
            --bind="ctrl-n:execute(tmux new-session -d -s)+reload(tmux list-sessions -F \"#{session_name}\")" \
            --bind="ctrl-x:execute(tmux kill-session -t {})+reload(tmux list-sessions -F \"#{session_name}\")") 
    [ -n "$selected" ] && tmux switch-client -t "$selected"'

command="display-popup -T '🗄️Session selector' -E '$command'"
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
tmux set-option -g pane-active-border-style "fg=$SOURCE"
tmux set-option -g status-style "bg=terminal fg=$SOURCE"
# tmux set -g status-position bottom
