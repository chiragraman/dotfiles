#!/bin/sh

# Get the URL of the zip file with "Fira_Code" in the file name from amongst the release assets
zip_url=$(curl --silent "https://api.github.com/repos/tonsky/FiraCode/releases/latest" | \
    jq -r '.assets[] | select(.name | contains("Fira_Code")) | .browser_download_url' | sed 's/\\//g')

install() {
	curl -L -s -o /tmp/fira.zip "$zip_url"
	unzip /tmp/fira.zip -d /tmp/FiraCode
	cp /tmp/FiraCode/*.ttf "$1"
}

if [ "$(uname -s)" = "Linux" ]; then
    sudo apt install fonts-firacode
elif [ "$(uname -s)" = "Darwin" ]; then
		install ~/Library/Fonts
fi
