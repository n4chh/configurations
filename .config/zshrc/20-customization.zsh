# -----------------------------------------------------
# CUSTOMIZATION
# -----------------------------------------------------
POSH=agnoster

# -----------------------------------------------------
# oh-myzsh themes: https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# -----------------------------------------------------
# ZSH_THEME=robbyrussell

# -----------------------------------------------------
# oh-myzsh plugins
# -----------------------------------------------------
plugins=(
    git
    sudo
    web-search
	# zsh-vi-mode
    zsh-autosuggestions
    zsh-syntax-highlighting
    # fast-syntax-highlighting
    copyfile
    copybuffer
    dirhistory
)

# Set-up oh-my-zsh

source $ZSH/oh-my-zsh.sh

# -----------------------------------------------------
# Set-up FZF key bindings (CTRL R for fuzzy history finder)
# -----------------------------------------------------
source <(fzf --zsh)

# zsh history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# -----------------------------------------------------
# Prompt
# -----------------------------------------------------
# eval "$(oh-my-posh init zsh)"

# -----------------------------------------------------
# Carapace
# -----------------------------------------------------
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

# function zvm_after_select_vi_mode() {
#   case $ZVM_MODE in
#     $ZVM_MODE_NORMAL)
# 		export ZVM_MODE_NORMAL=1
# 		unset ZVM_MODE_INSERT
# 		unset ZVM_MODE_VISUAL
# 		unset ZVM_MODE_VISUAL_LINE
# 		unset ZVM_MODE_REPLACE
#       # Something you want to do...
#     ;;
#     $ZVM_MODE_INSERT)
# 		unset ZVM_MODE_NORMAL
# 		export ZVM_MODE_INSERT=1
# 		unset ZVM_MODE_VISUAL
# 		unset ZVM_MODE_VISUAL_LINE
# 		unset ZVM_MODE_REPLACE
#       # Something you want to do...
#     ;;
#     $ZVM_MODE_VISUAL)
# 		unset ZVM_MODE_NORMAL
# 		unset ZVM_MODE_INSERT
# 		export ZVM_MODE_VISUAL=1
# 		unset ZVM_MODE_VISUAL_LINE
# 		unset ZVM_MODE_REPLACE
#       # Something you want to do...
#     ;;
#     $ZVM_MODE_VISUAL_LINE)
# 		unset ZVM_MODE_NORMAL
# 		unset ZVM_MODE_INSERT
# 		unset ZVM_MODE_VISUAL
# 		export ZVM_MODE_VISUAL_LINE=1
# 		unset ZVM_MODE_REPLACE
#       # Something you want to do...
#     ;;
#     $ZVM_MODE_REPLACE)
# 		unset ZVM_MODE_NORMAL
# 		unset ZVM_MODE_INSERT
# 		unset ZVM_MODE_VISUAL
# 		unset ZVM_MODE_VISUAL_LINE
# 		export ZVM_MODE_REPLACE=1
#       # Something you want to do...
#     ;;
#   esac
# }
