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

function download_nerd_fonts() {
    curl -SfsLo /tmp/FiraCode.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraCode.zip
    sudo unzip -d /usr/local/share/fonts /tmp/FiraCode.zip
}

function install_zsh_plugins() {
    $ZSH_CUSTOM=$HOME/.oh-my-zsh
    log 1 "Installing oh-my-posh"
    [ -f /usr/local/bin/oh-my-posh ] || (curl -s https://ohmyposh.dev/install.sh | sudo bash -s -- -d /usr/local/bin)
    log 1 "Installing oh-my-zsh"
    if ! $sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended; then
        log 2 "There was an error while installing oh-my-zsh"
    fi
    ZSH_CUSTOM=$HOME/.oh-my-zsh
    log 1 "Installing zsh-autosuggestions"
    $sudo git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
    log 1 "Installing zsh-syntax-highlighting"
    $sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    log 1 "Installing fast-fast-syntax-highlighting"
    $sudo git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git \
        ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
}

function configure_zsh() {
    local old_home=$HOME
    if [ $USER == "root" ]; then
        HOME=/root
        sudo=sudo
    fi
    if yes_or_no "Would you like to configure ZSH plugins for $USER?"; then
        install_zsh_plugins
    fi
    $sudo cp ./.zshrc ~
    $sudo cp -r ./.config/ohmyposh ~/.config
    $sudo cp -r ./.config/zshrc ~/.config
    HOME=$old_home
}

function install_utilities() {
    local packages=(
        "fzf"
        "lazygit"
        "fastfetch"
        "fd-find"
        "tmux"
        "eza"
    )
    log 1 "Installing ${packages[*]}"
    sudo apt install ${packages[*]}
    log 1 "Installing nvm"
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
}
function install_neovim() {
    sudo apt install neovim
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

[ -d ~/.config ] || mkdir ~/.config

if yes_or_no "Would you like to install utilities?"; then
    install_utilities
fi

if yes_or_no "Would you like to install Neovim?"; then
    install_neovim
fi

if yes_or_no "Would you like to configure ZSH for $USER?"; then
    configure_zsh
fi
old_user=$USER
USER=root
if yes_or_no "Would you like to configure ZSH for $USER?"; then
    configure_zsh
fi
USER=old_user

cp -r .config/* ~/.config
log 0 Source files copied
wallpaper="/usr/share/backgrounds/kali-16x9/kali-tiles.jpg"
if ! [ -f "$wallpaper" ]; then
    log 3 "Could not detect actual wallpaper."
    log 1 "Info:"
    echo $wallpaper
    exit 1
fi
log 1 "Wallpaper detected $wallpaper"

matugen image "$wallpaper"

log 0 "Setup completed"
