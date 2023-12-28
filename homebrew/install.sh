#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

# Check for Homebrew and Install
if test "$(uname -s)" = "Darwin" -a ! "$(which brew)"; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Add the command to set variables to .zprofile
if [ -f ~/.zprofile ] && grep -q 'eval "\$(/opt/homebrew/bin/brew shellenv)"' ~/.zprofile; then
    echo "The command for brew shellenv is already present in ~/.zprofile"
else
    printf '%s\n' '# Sets various variables and adds them to path' 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    echo "The command for brew shellenv has been added to ~/.zprofile"
fi