RED=\033[0;31m
CYAN=\033[0;36m
MAGENTA=\033[0;35m
NC=\033[0m

default: welcome git brew brewinstall vim dotfiles finder screenshots

welcome:
	@echo " > ${MAGENTA}Configuring all the things.${NC}"
	chmod +x ~/dotfiles/helper/*.sh
	chmod +x ~/dotfiles/shell/*

git:
	mkdir -p ~/dotfiles/build
	@echo " > ${MAGENTA}Configuring git.${NC}"
	~/dotfiles/helper/git.sh

brew:
	@echo " > ${MAGENTA}Installing brew and dependencies.${NC}"
	~/dotfiles/helper/brew.sh

brewinstall:
	cat ./brew.txt | xargs brew install

ffmpeg:
	brew tap homebrew-ffmpeg/ffmpeg
	brew install homebrew-ffmpeg/ffmpeg/ffmpeg --with-fdk-aac --with-librsvg --with-libsoxr --with-opencore-amr --with-openh264 --with-openjpeg --with-rav1e --with-webp --with-zimg --with-libxml2 --with-libgsm --with-speex --with-xvid

vim:
	@echo " > ${MAGENTA}Moving vim bundles.${NC}"
	mkdir -p ~/.vim
	cp -R ~/dotfiles/vim/ ~/.vim/

dotfiles:
	@echo " > ${MAGENTA}Moving dotfiles.${NC}"
	touch ~/dotfiles/dot/env
	~/dotfiles/helper/dotfiles.sh

finder:
	# add full path to finder top bar
	defaults write com.apple.finder _FXShowPosixPathInTitle -bool true; killall Finder

screenshots:
	mkdir -p ~/Pictures/screenshots
	defaults write com.apple.screencapture location ~/Pictures/screenshots
	killall SystemUIServer

latex:
	# install MacTeX
	pip3 install Pygments
