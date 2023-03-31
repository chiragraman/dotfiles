#!/bin/sh
###
# File: install.sh
# Created Date: Friday, March 31st 2023, 3:02:31 pm
# Author: Chirag Raman
#
# Copyright (c) 2023 Chirag Raman
###


if [ "$(uname)" = "Linux" ]; then
    wget -O /tmp/chruby-0.3.9.tar.gz \
        https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
    tar -xzvf /tmp/chruby-0.3.9.tar.gz
    (cd chruby-0.3.9/ && exec sudo make install)
    rm /tmp/chruby-0.3.9.tar.gz
fi