#!/bin/sh
###
# File: install.sh
# Created Date: Wednesday, December 27th 2023, 6:49:33 pm
# Author: Chirag Raman
#
# Copyright (c) 2023 Chirag Raman
###


if [ "$(uname -s)" = "Darwin" ]; then
    sudo ln -sf "/Applications/Hyper.app/Contents/Resources/bin/hyper" "/usr/local/bin/hyper"
fi