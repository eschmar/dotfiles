RED=\033[0;31m
CYAN=\033[0;36m
MAGENTA=\033[0;35m
NC=\033[0m

default: welcome git brew php nano dotfiles

welcome:
	@echo " > ${MAGENTA}Configuring all the things.${NC}"
	chmod +x ~/dotfiles/shell/*.sh

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
	export PATH=$PATH:~/.composer/vendor/bin && valet install
	mkdir -p ~/Sites
	cd ~/Sites && valet park

nano:
	@echo " > ${MAGENTA}Configuring Nano.${NC}"
	brew --link nano
	include "/usr/local/Cellar/nano/*/share/nano/*.nanorc"

dotfiles:
	@echo " > ${MAGENTA}Moving dotfiles.${NC}"
	~/dotfiles/shell/dotfiles.sh

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
