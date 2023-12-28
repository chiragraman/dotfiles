#!/bin/zsh
###
# File: path.sh
# Created Date: Thursday, December 28th 2023, 1:18:18 am
# Author: Chirag Raman
#
# Copyright (c) 2023 Chirag Raman
###

if [[ -z $ZPLUG_HOME ]]; then
    if [ "$(uname -s)" = "Darwin" ] && brew ls --versions zplug > /dev/null 2>&1; then
        export ZPLUG_HOME="/opt/homebrew/opt/zplug"
    elif [ "$(uname -s)" = "Linux" ]; then
        export ZPLUG_HOME=$HOME/.zplug
    fi
fi
