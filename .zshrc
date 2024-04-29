# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Fix the Java Problem
export _JAVA_AWT_WM_NONREPARENTING=1

for file in /home/parrot/.config/funciones/*.zsh; do
    source "$file"
done

[ -f '/home/parrot/.local/target.txt' ] &&  export TARGET="$(cat /home/parrot/.local/target.txt)"
[ -f '/home/parrot/.local/targetdir.txt' ] &&  export TARGETDIR="$(cat /home/parrot/.local/targetdir.txt)"
[ -f '/home/parrot/.local/workspace.txt' ] && export WS="$(cat /home/parrot/.local/workspace.txt)"
# export JAVA_HOME="$(/usr/libexec/java_home)"

export EDITOR=nvim
export VISUAL=nvim
#
# INCLUSION BINARIOS
#
# Export PATH$
export PATH=~/.local/bin:/snap/bin:/usr/sandbox/:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games:/usr/share/games:/usr/local/sbin:/usr/sbin:/sbin:/opt/bin:/opt/nvim-linux64/bin:$PATH
#Binarios go
export PATH=$PATH:$HOME/go/bin
# BINARIOS PROPIOS
export PATH="$HOME/.config/bin:$PATH"
# BINARIOS YARN
export PATH="$HOME/.yarn/bin:$PATH"
# BINARIOS CARGO
export PATH="$PATH:$HOME/.cargo/bin"
# BINARIOS PYTHON
export PATH="$PATH:$HOME/.local/bin"
# BINARIOS RVM
export PATH="$PATH:$HOME/.rvm/bin"
# alias
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
#
#-------/ CUSTOM ALIASES /-------
#
alias ls='ls -F --color=auto'
alias ll='lsd -lhF --group-dirs=first'
alias la='lsd -laF --group-dirs=first'
alias l='lsd -F --group-dirs=first'

source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
# Colores zsh
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=#00e1ff,underline
ZSH_HIGHLIGHT_STYLES[precommand]=fg=#00e1ff,underline
ZSH_HIGHLIGHT_STYLES[arg0]=fg=#00e1ff
#####################################################
# Auto completion / suggestion
# Mixing zsh-autocomplete and zsh-autosuggestions
# Requires: zsh-autocomplete (custom packaging by Parrot Team)
# Jobs: suggest files / foldername / histsory bellow the prompt
# Requires: zsh-autosuggestions (packaging by Debian Team)
# Jobs: Fish-like suggestion for command history
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /usr/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# source /usr/share/zsh-sudo/sudo.plugin.zsh
# Select all suggestion instead of top on result only
zstyle ':autocomplete:tab:*' insert-unambiguous yes
zstyle ':autocomplete:tab:*' widget-style menu-select
zstyle ':autocomplete:*' min-input 2
bindkey $key[Up] up-line-or-history
bindkey $key[Down] down-line-or-history



# Save type history for completion and easier life
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# setopt appendhistory
setopt histignorealldups sharehistory

#
#
# ------------/ AUTOCOMPLETADO /-------------
#
#
#

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'


# source ~/.promptrc.sh
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
