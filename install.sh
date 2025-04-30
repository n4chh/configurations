#!/bin/bash

curl -SsLo /tmp/FiraCode.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/FiraCode.zip

sudo unzip -d /usr/local/share/fonts /tmp/FiraCode.zip

cd src/alacritty
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
