#!/bin/bash
dir=~/dotfiles/dot
files="bash_profile zshenv nanorc alias vimrc env"

for file in $files; do
	rm -f ~/.$file
	ln -s $dir/$file ~/.$file
done

mkdir -p ~/.config/ghostty
ln -s ~/dotfiles/ghostty/config ~/.config/ghostty/config
