# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi
PROMPT=parrot
. ~/.prompt.zsh

for file in /Users/nachh/.config/funciones/*.zsh; do 
  source "$file"
done


export TARGETDIR="$(cat /Users/nachh/.local/targetdir.txt)"
export TARGET="$(cat /Users/nachh/.local/target.txt)"
export WS="$(cat /users/nachh/.local/workspace.txt)"
# export JAVA_HOME="$(/usr/libexec/java_home)"
# powersploit path
export PS="/opt/homebrew/share/powersploit"

#
# INCLUSION BINARIOS
#
# READELF Y UTILIDADES PARA BINARIOS
# export PATH="/usr/local/opt/brew/opt/binutils/bin:$PATH"
# PYTHON TO PYTHON3
export PATH="/opt/homebrew/opt/python@3.11/libexec/bin:$PATH"
# JOHN tools
export PATH="/opt/homebrew/Cellar/john-jumbo/1.9.0_1/share/john:$PATH"
# OPENSSL PATH
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"
# ERROR PATH DOCKER 
export PATH="$PATH:/usr/local/bin"
# HOMEBREW
eval "$(/opt/homebrew/bin/brew shellenv)"
# Brew binary
export PATH="/opt/homebrew/bin:$PATH"
# CURL binarios
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
# Ruby Version Manager
export PATH="$HOME/.rvm/bin:$PATH"
# BINARIOS PROPIOS
export PATH="$HOME/.config/bin:$PATH"
# pycurl
export PATH="~/pycurl/curl-7.86.0/bin:$PATH"
# Go
export GOROOT=/usr/local/go
export PATH="/usr/local/go/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export LDFLAGS="-L~/pycurl/curl-7.86.0/lib -L/opt/homebrew/Cellar/openssl@3/3.1.1_1/lib"
export CPPFLAGS="-I~/pycurl/curl-7.86.0/include -I/opt/homebrew/Cellar/openssl@3/3.1.1_1/include"
# Bin Utils path, puede causar fallo de compatibilidad con ciertas binarios no recuerdo cual
# export PATH="/opt/homebrew/opt/binutils/bin:$PATH"
# FINDUTILS
export PATH="/opt/homebrew/opt/findutils/libexec/gnubin:$PATH"
#VMWARE OVF TOOLS
export PATH="$PATH:/Applications/VMware OVF Tool"
#PIPx Binarios
export PATH="$PATH:$HOME/.local/bin"
#Binarios Arch64
export PATH="$PATH:/usr/local/opt/brew/bin"
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
# Binario NEO4J
export PATH="/Users/nachh/.config/neo4j/bin/:$PATH"
set NEO4J_ACCEPT_LICENSE_AGREEMENT=yes
set NEO4J_ACCEPT_LICENSE_AGREEMENT=eval

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# export GOROOT=/opt/homebrew/bin/go
# export GOPATH=$HOME/go
# .NET path
# export PATH="/usr/local/share/dotnet:$PATH"
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

#####################################################
# Auto completion / suggestion
# Mixing zsh-autocomplete and zsh-autosuggestions
# Requires: zsh-autocomplete (custom packaging by Parrot Team)
# Jobs: suggest files / foldername / histsory bellow the prompt
# Requires: zsh-autosuggestions (packaging by Debian Team)
# Jobs: Fish-like suggestion for command history
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=6,underline
ZSH_HIGHLIGHT_STYLES[precommand]=fg=6,underline
ZSH_HIGHLIGHT_STYLES[arg0]=fg=6

source /opt/homebrew/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
export EDITOR=vim
# Select all suggestion instead of top on result only
# zstyle ':autocomplete:tab:*' insert-unambiguous yes
# zstyle ':autocomplete:tab:*' widget-style menu-select
# zstyle ':autocomplete:*' min-input 2
# bindkey $key[Up] up-line-or-history
# bindkey $key[Down] down-line-or-history


##################################################
# Fish like syntax highlighting
# Requires "zsh-syntax-highlighting" from apt

fpath=(~/.zsh/completion $fpath)
autoload -U compinit
compinit
# Save type history for completion and easier life
# HISTFILE=~/.zsh_history
# HISTSIZE=10000
# SAVEHIST=10000
# setopt appendhistory
# setopt histignorealldups sharehistory

# Useful alias for benchmarking programs
# require install package "time" sudo apt install time
# alias time="/usr/bin/time -f '\t%E real,\t%U user,\t%S sys,\t%K amem,\t%M mmem'\
#
zstyle ':autocomplete:tab:*' insert-unambiguous yes
zstyle ':autocomplete:tab:*' widget-style menu-select
zstyle ':autocomplete:*' min-input 2
bindkey $key[Up] up-line-or-history
bindkey $key[Down] down-line-or-history
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(gdircolors -b)"
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

# bun completions
[ -s "/Users/nachh/.bun/_bun" ] && source "/Users/nachh/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
unset zle_bracketed_paste
