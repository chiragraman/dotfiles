#!/bin/zsh
###
# File: plugins.zsh
# Created Date: Friday, June 11th 2021, 8:02:22 pm
# Author: Chirag Raman
#
# Copyright (c) 2021 Chirag Raman
###

if [[ -z $ZPLUG_HOME ]]; then
    source "$DOTFILES/zplug/path.zsh"
fi
source "$ZPLUG_HOME/init.zsh"

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "spaceship-prompt/spaceship-prompt", use:spaceship.zsh, from:github, as:theme
zplug "zplug/zplug", hook-build:"zplug --self-manage"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

