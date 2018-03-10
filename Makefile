RED=\033[0;31m
CYAN=\033[0;36m
MAGENTA=\033[0;35m
NC=\033[0m

default: welcome git brew brewinstall php dotfiles

welcome:
	@echo " > ${MAGENTA}Configuring all the things.${NC}"
	chmod +x ~/dotfiles/shell/*.sh
	chmod +x ~/dotfiles/alias/*

git:
	mkdir -p ~/dotfiles/build
	@echo " > ${MAGENTA}Configuring git.${NC}"
	curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ./build/.git-prompt.sh
	curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ./build/.git-completion.bash
	# test -f ./build/.git-completion.bash && . $_
	~/dotfiles/shell/gitconfig.sh

brew:
	@echo " > ${MAGENTA}Installing brew and dependencies.${NC}"
	~/dotfiles/shell/brew.sh

brewinstall:
	brew tap homebrew/php
	cat ./brew.txt | xargs brew install

php:
	@echo " > ${MAGENTA}Installing PHP and Environment.${NC}"
	composer global require laravel/valet
	valet install
	mkdir -p ~/Sites
	cd ~/Sites && valet park

dotfiles:
	@echo " > ${MAGENTA}Moving dotfiles.${NC}"
	~/dotfiles/shell/dotfiles.sh

#
#   //todo
#

# - gif.sh
# - heroku.sh
# - Sublime settings
# - Visual Studio Code Settings
# - patch-edid.rb? Display patch
