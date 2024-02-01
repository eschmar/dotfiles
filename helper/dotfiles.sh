#!/bin/bash
dir=~/dotfiles/dot
files="bash_profile zshenv nanorc alias vimrc env wezterm.lua"

for file in $files; do
    rm -f ~/.$file
    ln -s $dir/$file ~/.$file
done
