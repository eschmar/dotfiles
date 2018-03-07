#!/bin/bash
echo

RED='\033[0;31m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m'

printf " > ${MAGENTA}Configuring all the things.${NC}\n"

rm -rf ./build
mkdir -p ./build

#
#   Git
#

printf " > ${MAGENTA}Configuring git.${NC}\n"
# Git Autocomplete
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ./build/.git-prompt.sh
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ./build/.git-completion.bash
# test -f ./build/.git-completion.bash && . $_

# Git config
printf "\n\n"
read -p " > ${MAGENTA}Name for git config? " -r
echo

git config --global user.name "$REPLY"

printf "\n\n"
read -p " > ${MAGENTA}Email for git config? " -r
echo

git config --global user.email "$REPLY"

#
#   Dotfiles
#

printf " > ${MAGENTA}Moving dotfiles.${NC}\n"

dir=~/dotfiles/dot
files="bash_profile nanorc"

for file in $files; do
    ln -s $dir/$file ~/.$file
done

#
#   Brew
#

printf " > ${MAGENTA}Installing brew and dependencies.${NC}\n"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

#
#   Nano
#

brew install homebrew/dupes/nano

#
#   //todo
#

# - brew install list
# - gif.sh
# - heroku.sh
# - Sublime settings
# - Visual Studio Code Settings
# - Terminal settings, use own theme for everything?
# - php72/valet?
# - patch-edid.rb? Display patch
# - git config! prompt?
