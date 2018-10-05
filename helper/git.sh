#!/bin/bash

RED='\033[0;31m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m'

GIT_VERSION=$(git --version | grep -Eo -m 1 '[0-9]+[.][0-9]+[.][0-9]+' | head -1)

printf " > ${MAGENTA}Your git version is ${CYAN}v${GIT_VERSION}${NC}\n\n"
curl https://raw.githubusercontent.com/git/git/v${GIT_VERSION}/contrib/completion/git-prompt.sh -o ./build/.git-prompt.sh
curl https://raw.githubusercontent.com/git/git/v${GIT_VERSION}/contrib/completion/git-completion.bash -o ./build/.git-completion.bash

# Git config
printf "\n > ${MAGENTA}Name for git config?${NC}"
read -p " " -r

git config --global user.name "$REPLY"

printf " > ${MAGENTA}Email for git config?${NC}"
read -p " " -r

git config --global user.email "$REPLY"
