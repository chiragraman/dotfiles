#!/bin/zsh


install_fira_code() {
    # Get the URL of the zip file with "Fira_Code" in the file name from amongst the release assets
    zip_url=$(curl --silent "https://api.github.com/repos/tonsky/FiraCode/releases/latest" | \
        jq -r '.assets[] | select(.name | contains("Fira_Code")) | .browser_download_url' | sed 's/\\//g')
    # Download and install the latest version of Fira Code
    curl -L -s -o /tmp/fira.zip "$zip_url"
	unzip /tmp/fira.zip -d /tmp/fira-code
	cp -v /tmp/fira-code/ttf/*.ttf "$1"
    # Cleanup
    rm -rf /tmp/fira-code
    rm /tmp/fira.zip
}

install_atkinson_hyperlegible() {
    # Download the Atkinson Hyperlegible font from Google Fonts
    curl -L -s -o /tmp/atkinson-hyperlegible.zip "https://fonts.google.com/download?family=Atkinson+Hyperlegible"
    unzip /tmp/atkinson-hyperlegible.zip -d /tmp/atkinson-hyperlegible
    cp -v /tmp/atkinson-hyperlegible/**/*.ttf "$1"
    # Cleanup
    rm -rf /tmp/atkinson-hyperlegible
    rm /tmp/atkinson-hyperlegible.zip
}

# Install all fonts
install_fonts() {
    install_atkinson_hyperlegible "$1"
    install_fira_code "$1"
}

# Set target dir
if [ "$(uname -s)" = "Linux" ]; then
    font_target_dir="$HOME/.local/share/fonts/"
elif [ "$(uname -s)" = "Darwin" ]; then
	font_target_dir="$HOME/Library/Fonts"
fi

# Call the install_fonts function
install_fonts $font_target_dir
