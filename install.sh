#!/usr/bin/env bash

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
    curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip -o /tmp/Symbols.zip
    sudo unzip -d /usr/share/fonts/NFSymbols /tmp/Symbols.zip
}

function install_zsh_plugins() {

    log 1 "Installing oh-my-posh"
	curl -s https://ohmyposh.dev/install.sh | sudo bash -s

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

	log 1 "Installing zsh"
	sudo emerge -a "app-shells/zsh"
	log 1 "Installing carapace"
	sudo emerge -a "app-shells/carapace"
    log 1 "Installing fzf"
	sudo emerge -a "app-shells/fzf"
    log 1 "Installing nvm"
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
    log 1 "Installing lazygit"
	sudo emerge -a "dev-vcs/lazygit"
    log 1 "Installing fd"
    sudo emerge -a "sys-apps/fd"
    log 1 "Installing tmux"
	sudo emerge -a "app-misc/tmux"
    log 1 "Installing eza"
	sudo emerge -a "sys-apps/eza"
}
function install_neovim() {
	sudo emerge -a "app-editors/neovim"
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

cp .zshrc ~
cp -r .config/* ~/.config
log 0 Source files copied

log 0 "Setup completed"
