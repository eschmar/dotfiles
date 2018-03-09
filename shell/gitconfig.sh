# Git config
read -p " > ${MAGENTA}Name for git config? " -r
echo

git config --global user.name "$REPLY"

printf "\n\n"
read -p " > ${MAGENTA}Email for git config? " -r
echo

git config --global user.email "$REPLY"
