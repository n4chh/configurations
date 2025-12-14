#!/usr/bin/env bash

BASE_PATH="$HOME/.config/tmux/themes"
DEFAULT_THEME="$BASE_PATH/gentoo"

get_theme() {
	local theme="$1"

	if [[ -z "$theme" ]]; then
		echo "$DEFAULT_THEME"
		return
	fi

	if ! [[ -d "$BASE_PATH/$theme" ]]; then
		echo "$DEFAULT_THEME"
		return
	fi

	theme="$BASE_PATH/$theme"
	if [[ -f "$theme/theme.sh" ]]; then
		echo "$theme"
	else
		echo "$DEFAULT_THEME"
	fi

}

change_theme() {
	local script_path="$BASE_PATH/selector.sh"
	local new_theme="$1"	
	if [[ -z $new_theme ]]; then
		return 1
	fi
	sed -i '' 's/\(DEFAULT_THEME="$BASE_PATH\/\).*"/\1'"$new_theme"'"/g' "$script_path"
}

source_theme() {
	local theme="$(get_theme $1)"
	cd "$theme"
	source "$theme/theme.sh"
}



fzf_theme_selector() {
	local oifs=$IFS
	IFS=$' '
	local themes=($(/bin/ls -d ~/.config/tmux/themes/*/ | xargs -n 1 basename))
	IFS="$oifs"

    echo "$themes" | fzf --prompt="Select session: " \
            --header="Current: $DEFAULT_THEME" \
			--preview="source $BASE_PATH/selector.sh; source_theme {}" \
            --preview-window=right:60% \
			--bind="esc:execute(source $BASE_PATH/selector.sh; source_theme)+abort" \
			--bind="enter:execute(source $BASE_PATH/selector.sh; source_theme {}; change_theme {})+accept"
}

if [[ "${BASH_SOURCE[0]}" == "$0" ]]; then
	command="display-popup -T '🎨Theme selector' -E 'source ~/.config/tmux/themes/selector.sh; fzf_theme_selector'"
	tmux bind-key -Troot F3 "$command"
	source_theme 
fi


