#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.
[ "$(uname -s)" != "Darwin" ] && exit 0

# Check for Homebrew
if test ! "$(which brew)"; then
  echo "  Installing Homebrew for you."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update

# more formualae
brew tap phinze/homebrew-cask || true
brew tap caskroom/versions || true
brew install brew-cask

# usefull stuff
brew install grc coreutils the_silver_searcher htop-osx \
    wget unrar ffmpeg gifsicle terminal-notifier spark
brew cask install iterm2 the-unarchiver disk-inventory-x appcleaner \
    diffmerge android-file-transfer evernote

#editor
brew cask install atom

# virtualization
brew cask install virtualbox

# chat, books, notes, documents, mail, etc
brew cask install mendeley-desktop dropbox skype slack telegram

# browser
brew cask install google-chrome

# gaming
brew cask install steam

# fonts
brew tap caskroom/fonts
brew cask install font-source-code-pro

# databases et al
brew install redis
brew cask install postgres

# watch and download stuff
brew install youtube-dl
brew cask install subtitles beamer vlc transmission

# quick look plugins - https://github.com/sindresorhus/quick-look-plugins
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json \
  qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook \
  suspicious-package

# clean things up
brew cleanup
brew cask cleanup
