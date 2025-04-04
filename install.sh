#!/bin/bash

cd src/alacritty
for file in *;
do
	echo "Coping $file"
	install -D $folder "~/.config/alacritty/$file"
done
cd ../scripts
for file in *;
do
	echo "Coping $file"
	install -Dm 755 $folder "~/.config/scripts/$file"
done

