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
    curl -fsSL https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/NerdFontsSymbolsOnly.zip -o /tmp/NerdFontsSymbolsOnly.zip
    unzip -d /usr/local/share/fonts/ /tmp/NerdFontsSymbolsOnly.zip
}

function install_zsh() {
	log 1 "Installing zsh"
	sudo apt install zsh
	log 1 "Installing carapace completions"
	curl -fsSL https://github.com/carapace-sh/carapace-bin/releases/download/v1.5.3/carapace-bin_1.5.3_linux_amd64.tar.gz -o ~/.local/bin/carapace.tar.gz
	tar -xzf ~/.local/bin/carapace.tar.gz -C ~/.local/bin	
	rm ~/.local/bin/{README.md,LICENSE,carapace.tar.gz}

	if yes_or_no "Would you like to set zsh as default shell for current user?"; then
		user=$USER
		sudo chsh -s /usr/bin/zsh "$user"
	fi
	if yes_or_no "Would you like to set zsh as default shell for root user?"; then
		user=$USER
		sudo chsh -s /usr/bin/zsh "root"
	fi
}

function install_zsh_plugins() {

    log 1 "Installing oh-my-posh"
	curl -s https://ohmyposh.dev/install.sh | bash -s

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
	log 1 "Installing curl"
	sudo apt install curl

	log 1 "Installing wl-clipboard"
	sudo apt install wl-clipboard

	log 1 "Installing ghostty"
	snap install ghostty --classic
	if yes_or_no "Do you want to set ghostty as the default terminal emulator"; then
		ghostty_path="$(which ghostty)"
		[[ -f "$ghostty_path" ]] || ghostty_path="/snap/ghostty/current/bin/ghostty"
		sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator "$ghostty_path" 50
	fi

    log 1 "Installing tmux"
    sudo apt install tmux

    log 1 "Installing fzf"
    sudo apt install fzf

    log 1 "Installing nvm"
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

    log 1 "Installing lazygit"
    sudo apt install lazygit

    log 1 "Installing fd"
    sudo apt install fd-find

    log 1 "Installing eza"
    sudo apt install eza

    log 1 "Installing fastfetch"
    sudo apt install fastfetch
}

function install_dev_pkg() {
	log 1 "Installing C tools"
	sudo apt install build-essential
	log 1 "Installing Rust tools"
	sudo apt install rustup
	log 1 "Installing Go"
	snap install --classic go
}

function install_neovim() {
    snap install --edge nvim --classic
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
	install_zsh
    install_zsh_plugins
fi

cp .zshrc ~
cp -r .config/* ~/.config
log 0 Source files copied

#
# This part will allow to configure system with matugen
#
# if yes_or_no "Would you like to setup config files with matugen?"; then
#     if ! which matugen 2>/dev/null 1>&2; then
#         log 2 "Can't find matugen. "
#         log 1 "Installing it . . ."
#         if ! cargo install matugen; then
#             log 3 There was an error while installing matugen.
#             exit 1
#         fi
#     fi
#     wallpaper="$(gsettings get org.gnome.desktop.background picture-uri)"
#
#     if ! [ -f "$wallpaper" ]; then
#         log 3 "Could not detect actual wallpaper."
#         log 1 "Info:"
#         echo $wallpaper
#         exit 1
#     fi
#     log 1 "Wallpaper detected $wallpaper"
#
#     matugen image "$wallpaper"
# fi

log 0 "Setup completed"
