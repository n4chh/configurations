#!/bin/bash

curl -SsLo /tmp/FiraCode.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraCode.zip

sudo unzip -d /usr/local/share/fonts /tmp/FiraCode.zip

cd src/kitty
mkdir -p "$HOME/.config/kitty"
mkdir -p "$HOME/.config/tmux"
mkdir -p "$HOME/.config/scripts"
mkdir -p "$HOME/.config/i3"
git clone https://github.com/alacritty/alacritty-theme ~/.config/alacritty/themes
for file in 
for file in *; do
    echo "Coping alacritty/$file"
    install -D $file "$HOME/.config/alacritty/$file"
done
cd ../scripts
for file in *; do
    echo "Coping scripts/$file"
    install -Dm 755 $file "$HOME/.config/scripts/$file"
done
cd ../tmux
for file in *; do
    echo "Coping tmux/$file"
    install -D $file "$HOME/.config/tmux/$file"
done
cd ../i3
for file in *; do
    echo "Coping i3/$file"
    install -D $file "$HOME/.config/i3/$file"
done
