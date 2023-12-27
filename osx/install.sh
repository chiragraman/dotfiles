#!/bin/sh
[ "$(uname -s)" != "Darwin" ] && exit 0
echo "\n› sudo softwareupdate -ia"
sudo softwareupdate -ia
