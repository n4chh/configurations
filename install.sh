#!/bin/bash

cd src/alacritty
for file in *;
do
	echo "Coping $file"
	install -D $file "$HOME/.config/alacritty/$file"
done
cd ../scripts
for file in *;
do
	echo "Coping $file"
	install -Dm 755 $file "$HOME/.config/scripts/$file"
done

