#!/bin/sh
[ "$(uname -s)" = "Darwin" ] && exit 0
mkdir -p ~/.config/terminator/
ln -sf "$DOTFILES"/terminator/config ~/.config/terminator/config
