#!/bin/zsh
###
# File: path.sh
# Created Date: Thursday, December 28th 2023, 1:18:18 am
# Author: Chirag Raman
#
# Copyright (c) 2023 Chirag Raman
###


if command -v brew > /dev/null 2>&1; then
    if brew ls --versions zplug > /dev/null 2>&1; then
        export ZPLUG_HOME="/opt/homebrew/opt/zplug"
        source "$ZPLUG_HOME/init.zsh"
    fi
fi
