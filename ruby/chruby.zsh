#!/bin/sh
###
# File: chruby.zsh
# Created Date: Wednesday, February 1st 2023, 1:20:04 am
# Author: Chirag Raman
#
# Copyright (c) 2023 Chirag Raman
###

if [ "$(uname)" = "Linux" ]; then
    source /usr/local/share/chruby/chruby.sh
    source /usr/local/share/chruby/auto.sh
elif [ "$(uname -s)" = "Darwin" ]; then
    source $(brew --prefix)/opt/chruby/share/chruby/chruby.sh
    source $(brew --prefix)/opt/chruby/share/chruby/auto.sh
fi