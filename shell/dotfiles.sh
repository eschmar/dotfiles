#!/bin/bash
dir=~/dotfiles/dot
files="bash_profile nanorc"

for file in $files; do
    ln -s $dir/$file ~/.$file
done
