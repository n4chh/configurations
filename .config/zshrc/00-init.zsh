# -----------------------------------------------------
# INIT
# -----------------------------------------------------

# -----------------------------------------------------
# Exports
# -----------------------------------------------------
export EDITOR=nvim
export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:~/.cargo/bin/

# -----------------------------------------------------
# HomeBrew
# -----------------------------------------------------

eval "$(/opt/homebrew/bin/brew shellenv)"

# -----------------------------------------------------
# Node Version Manager
# -----------------------------------------------------
# [ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"
# [ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix nvm)/etc/bash_completion.d/nvm"

# -----------------------------------------------------
# Pyenv
# -----------------------------------------------------
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

# -----------------------------------------------------
# Android Studio
# -----------------------------------------------------
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"

# -----------------------------------------------------
# Fpath
# -----------------------------------------------------
fpath=(/opt/metasploit-framework/embedded/framework/external/zsh $fpath)

