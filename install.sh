#!/bin/bash

function log() {
    case "$1" in
    0 | SUCCESS)
        shift
        echo "[$(tput setaf 2)+$(tput sgr0)] $@"
        ;;
    1 | INFO)
        shift
        echo "[$(tput setaf 4)*$(tput sgr0)] $@"
        ;;
    2 | WARNING)
        shift
        echo "[$(tput setaf 3)!$(tput sgr0)] $@"
        ;;
    3 | ERROR)
        shift
        echo "[$(tput setaf 1 bold)X$(tput sgr0)] $@"
        ;;
    4 | QUESTION)
        shift
        echo "[$(tput setaf 5 bold)?$(tput sgr0)] $@"
        ;;
    *)
        echo "$@"
        ;;
    esac

}

function yes_or_no() {
    local input="init"
    while [[ $input != "y" ]] && [[ $input != "n" ]]; do
        log 4 "$@ $(tput setaf 6)(y/n)$(tput sgr0)"
        read -p "> " -r input
    done
    if [ $input == "y" ]; then
        return 0
    else
        return 1
    fi
}

function get_wallpaper_path() {
    osascript -e '
    tell application "Finder"
    set theDesktopPic to desktop picture as alias
    set theName to posix path of theDesktopPic
    end tell'
}

function download_nerd_fonts() {
    curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip -o /tmp/JetBrainsMono.zip
    unzip -d ~/Library/Fonts/ /tmp/JetBrainsMono.zip
}

function install_zsh_plugins() {

    log 1 "Installing oh-my-posh"
    brew install jandedobbeleer/oh-my-posh/oh-my-posh

    log 1 "Installing oh-my-zsh"
    if ! sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended; then
        log 2 "There was an error while installing oh-my-zsh"
    fi
    ZSH_CUSTOM=~/.oh-my-zsh
    log 1 "Installing zsh-autosuggestions"
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
    log 1 "Installing zsh-syntax-highlighting"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    log 1 "Installing fast-fast-syntax-highlighting"
    git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
        ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
}

function install_utilities() {
    log 1 "Installing fzf"
    brew install fzf
    log 1 "Installing fastfetch"
    brew install fastfetch
    log 1 "Installing nvm"
    brew install nvm
    log 1 "Installing lazygit"
    brew install lazygit
    log 1 "Installing fd"
    brew install fd
    log 1 "Installing tmux"
    brew install tmux
    log 1 "Installing eza"
    brew install eza
}
function install_neovim() {
    brew install Neovim
    git clone https://github.com/n4chh/nvim.conf ~/.config/nvim
    log 0 "Neovim config installed"
}

if ! which matugen 2>/dev/null 1>&2; then
    log 2 "matugen is needed. "
    log 1 "Installing it . . ."
    if ! cargo install matugen; then
        log 3 There was an error while installing matugen.
        exit 1
    fi
fi
if yes_or_no "Would you like to install Homebrew?"; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

[ -d ~/.config ] || mkdir ~/.config

if yes_or_no "Would you like to install utilities?"; then
    install_utilities
fi

if yes_or_no "Would you like to install Neovim?"; then
    install_neovim
fi

if yes_or_no "Would you like to configure ZSH?"; then
    install_zsh_plugins
fi

cp .zshrc ~
cp -r .config/* ~/.config
log 0 Source files copied
wallpaper="$(get_wallpaper_path)"

if ! [ -f "$wallpaper" ]; then
    log 3 "Could not detect actual wallpaper."
    log 1 "Info:"
    echo $wallpaper
    exit 1
fi
log 1 "Wallpaper detected $wallpaper"

matugen image "$wallpaper"

log 0 "Setup completed"
