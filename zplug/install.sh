#!/bin/sh
###
# File: install.sh
# Created Date: Friday, June 11th 2021, 7:55:41 pm
# Author: Chirag Raman
#
# Copyright (c) 2021 Chirag Raman
###


if command -v brew > /dev/null 2>&1; then
	brew install zplug
else
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
fi
