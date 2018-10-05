#!/bin/bash
dir=~/dotfiles/dot
files="bash_profile nanorc alias vimrc env"

for file in $files; do
    rm -f ~/.$file
    ln -s $dir/$file ~/.$file
done
