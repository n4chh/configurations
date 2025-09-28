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
    curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Hermit.zip -o /tmp/Hermit.zip
    sudo unzip -d /usr/share/fonts /tmp/Hermit.zip
}

function install_zsh_plugins() {
    log 1 "Installing oh-my-posh"
	
    if ! curl -s https://ohmyposh.dev/install.sh | bash -s; then
        log 2 "There was an error while installing oh-my-zsh"
    fi
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

function install_sddm_theme() {
	local sddm_theme="catppuccin-latte-flamingo"
	log 1 "Installing dependencies"
	sudo pacman -Syu qt6-svg qt6-declarative qt5-quickcontrols2
	
	log 1 "Downloading theme"
	curl -fsSL "https://github.com/catppuccin/sddm/releases/download/v1.1.2/$sddm_theme-sddm.zip" -o "/tmp/$sddm_theme.zip"
	sudo unzip -d /usr/share/sddm/themes "/tmp/$sddm_theme.zip"
	log 3 "Theme installed"
}

function install_utilities() {
    log 1 "Installing brightnessctl"
    sudo pamcan -S brightnessctl
    log 1 "Installing fzf"
    sudo pamcan -S fzf
    log 1 "Installing fastfetch"
    sudo pamcan -S fastfetch
    log 1 "Installing nvm"
    sudo pamcan -S nvm
    log 1 "Installing lazygit"
    sudo pamcan -S lazygit
    log 1 "Installing fd"
    sudo pamcan -S fd
    log 1 "Installing tmux"
    sudo pamcan -S tmux
    log 1 "Installing eza"
    sudo pamcan -S eza
}
function install_neovim() {
    sudo pacman -S neovim
    git clone https://github.com/n4chh/nvim.conf ~/.config/nvim
    log 0 "Neovim config installed"
}

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

if yes_or_no "Would you likke to configure SDDM?"; then
	install_sddm_theme
fi

cp .zshrc ~
cp -r .config/* ~/.config
log 0 Source files copied
if yes_or_no "Would you like to setup config files with matugen?"; then
    if ! which matugen 2>/dev/null 1>&2; then
        log 2 "Can't find matugen. "
        log 1 "Installing it . . ."
        if ! cargo install matugen; then
            log 3 There was an error while installing matugen.
            exit 1
        fi
    fi
    wallpaper="$(get_wallpaper_path)"

    if ! [ -f "$wallpaper" ]; then
        log 3 "Could not detect actual wallpaper."
        log 1 "Info:"
        echo $wallpaper
        exit 1
    fi
    log 1 "Wallpaper detected $wallpaper"

    matugen image "$wallpaper"
fi

log 0 "Setup completed"
