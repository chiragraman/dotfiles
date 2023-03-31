#!/bin/sh
URL="https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.3/FiraCode.zip"

install() {
	curl -L -s -o /tmp/fira.zip "$URL"
	unzip /tmp/fira.zip -d /tmp/FiraCode
	cp /tmp/FiraCode/*.ttf "$1"
}

if [ "$(uname -s)" = "Linux" ]; then
    sudo apt install fonts-firacode
if [ "$(uname -s)" = "Darwin" ]; then
	if which brew >/dev/null 2>&1; then
		brew cask install font-firacode-nerd-font
		brew cask install font-firacode-nerd-font-mono
	else
		install ~/Library/Fonts
	fi
fi