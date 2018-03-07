source ~/dotfiles/build/.git-prompt.sh
source ~/dotfiles/build/.git-completion.bash

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export PS1="\n\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[32m\]\$(__git_ps1)\[\033[m\] \$ "

alias gl='git log --oneline --all --graph --decorate'
alias youtube-pl='youtube-dl --ignore-errors --extract-audio --audio-format mp3 --download-archive archive.txt'

export PATH="/usr/local/sbin:$PATH"
export PATH=$PATH:~/.composer/vendor/bin
export PATH=/usr/local/mysql/bin:$PATH
export PATH=$PATH:~/dotfiles/alias
