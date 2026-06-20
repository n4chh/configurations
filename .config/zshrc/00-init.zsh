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
# Android Studio
# -----------------------------------------------------
export PATH="$PATH:$HOME/Library/Android/sdk/platform-tools"

# -----------------------------------------------------
# Fpath
# -----------------------------------------------------
fpath=(/opt/metasploit-framework/embedded/framework/external/zsh $fpath)

# -----------------------------------------------------
# LLVM
# -----------------------------------------------------
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export CMAKE_PREFIX_PATH="/opt/homebrew/opt/llvm"

