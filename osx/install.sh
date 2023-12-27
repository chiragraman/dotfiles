#!/bin/sh
[ "$(uname -s)" != "Darwin" ] && exit 0
echo -e "\n› sudo softwareupdate -ia"
sudo softwareupdate -ia
