echo -e "[\e[36m#\e[0m] Starting zshrc."
global_init_time=$(date +'%s')

# -----------------------------------------------------
# Load modular configarion
# -----------------------------------------------------

for f in ~/.config/zshrc/*; do
    if [ ! -d $f ]; then

        c=`echo $f | sed -e "s=.config/zshrc=.config/zshrc/custom="`
		file_to_source=""
		[[ -f $c ]] && file_to_source="$c" || file_to_source="$f"
		echo -e "[\e[34m*\e[0m] Sourcing \"$file_to_source\"."
		init_time=$(date +'%s')
		source "$file_to_source"
		time_elapsed=$(($(date +'%s') - $init_time))
		echo -e "[\e[34m-\e[0m] Time used: $(date  -juf "%s" "$time_elapsed" +'%H hours %M minutes %S seconds')."
    fi
done

# -----------------------------------------------------
# Load single customization file (if exists)
# -----------------------------------------------------

if [ -f ~/.zshrc_custom ]; then
    source ~/.zshrc_custom
fi

# Amazon Q post block. Keep at the bottom of this file.
# # zprof

# Amazon Q post block. Keep at the bottom of this file.
# [[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
#
# [[ "$TERM_PROGRAM" == "kiro" ]] && . "$(kiro --locate-shell-integration-path zsh)"

# Added by Antigravity
export PATH="/Users/nachh/.antigravity/antigravity/bin:$PATH"

time_elapsed=$(($(date +'%s') - $global_init_time))
echo -e "[\e[32m$\e[0m] Shell initialized: $(date  -juf "%s" "$time_elapsed" +'%H hours %M minutes %S seconds')."
