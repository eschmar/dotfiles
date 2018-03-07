#!/bin/bash

rm -rf ./build
mkdir -p ./build

# Git Autocomplete
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ./build/.git-prompt.sh
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ./build/.git-completion.bash
# test -f ./build/.git-completion.bash && . $_
