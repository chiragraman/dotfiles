#!/bin/sh
###
# File: install.zsh
# Created Date: Friday, June 11th 2021, 7:55:41 pm
# Author: Chirag Raman
#
# Copyright (c) 2021 Chirag Raman
###


if [ "$(uname -s)" = "Darwin" ] && command -v brew > /dev/null 2>&1; then
    brew install zplug
elif [ "$(uname -s)" = "Linux" ]; then
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi
