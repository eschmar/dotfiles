#!/bin/bash

RED='\033[0;31m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m'

DIRECTORY='/Applications/Visual Studio Code.app'

if [ ! -d "$DIRECTORY" ]; then
    printf " > ${RED}Install visual studio code first.${NC}\n"
    exit
fi

export PATH="\$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

exts=(
    James-Yu.latex-workshop
    PKief.material-icon-theme
    bmewburn.vscode-intelephense-client
    dbaeumer.vscode-eslint
    felixfbecker.php-debug
    ikappas.phpcs
    mikestead.dotenv
    neilbrayfield.php-docblocker
    streetsidesoftware.code-spell-checker
)

for ext in ${exts[@]}; do
    code --install-extension $ext
done

ln -s ~/dotfiles/vscode/pew-theme ~/.vscode/extensions/pew-theme
